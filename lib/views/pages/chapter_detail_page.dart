import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../providers/language_provider.dart';

class ChapterDetailPage extends StatefulWidget {
  const ChapterDetailPage({super.key});

  @override
  State<ChapterDetailPage> createState() => _ChapterDetailPageState();
}

class _ChapterDetailPageState extends State<ChapterDetailPage> {
  late String verseJsonEnglish;

  Map<String, dynamic> verseJsonMapEnglish = {};
  Map<String, dynamic> verseMapEnglish = {};

  late String verseJsonHindi;

  Map<String, dynamic> verseJsonMapHindi = {};
  Map<String, dynamic> verseMapHindi = {};

  Map<String, dynamic>? chapterVersesEorG;

  void loadJson() async {
    verseJsonEnglish =
        await rootBundle.loadString('assets/JSON/bhagvad_gita_english.json');

    verseJsonMapEnglish = jsonDecode(verseJsonEnglish);
    verseMapEnglish = verseJsonMapEnglish['verses'];

    verseJsonHindi =
        await rootBundle.loadString('assets/JSON/bhagvad_gita_hindi.json');

    verseJsonMapHindi = jsonDecode(verseJsonHindi);
    verseMapHindi = verseJsonMapHindi['verses'];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  @override
  Widget build(BuildContext context) {
    final language =
        Provider.of<LanguageProvider>(context).languageModel.language;

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final chapter = args['chapter'] as Map<String, dynamic>;
    final chapterNumber = args['chapterNumber'] as String;

    chapterVersesEorG = (language == 'english')
        ? verseMapEnglish[chapterNumber]
        : verseMapHindi[chapterNumber];
    print(language);
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.png'),
            ),
          ),
          child: (verseMapEnglish.isEmpty || verseMapHindi.isEmpty)
              ? const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      leading: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.chevron_left,
                          size: 30,
                        ),
                      ),
                      centerTitle: true,
                      title: Text(
                        'Chapter Number: $chapterNumber',
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      floating: true,
                      snap: true,
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            '${chapter['name']}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 25,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: ReadMoreText(
                        trimMode: TrimMode.Line,
                        trimLines: 5,
                        trimCollapsedText: 'Read More',
                        trimExpandedText: 'Show Less',
                        delimiter: '......',
                        lessStyle: TextStyle(
                          color: Colors.lightBlue.shade200,
                          fontWeight: FontWeight.bold,
                        ),
                        moreStyle: TextStyle(
                          color: Colors.lightBlue.shade200,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        '${chapter['chapter_summary']}\n',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 25,
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final verse = chapterVersesEorG!['${index + 1}'];
                          return (verse == null)
                              ? const ListTile(
                                  title: Text('Verse Not Found'),
                                )
                              : ListTile(
                                  leading: Text(
                                    '${verse['verse_number']}',
                                    style: const TextStyle(fontSize: 25),
                                  ),
                                  title: Text('${verse['meaning']}'),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        'verse_detail_page',
                                        arguments: (verse));
                                  },
                                );
                        },
                        childCount: chapterVersesEorG?.length ?? 0,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
