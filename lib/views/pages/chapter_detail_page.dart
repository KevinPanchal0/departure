import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  Map verseJsonMapEnglish = {};
  Map verseMapEnglish = {};

  late String verseJsonHindi;

  Map verseJsonMapHindi = {};
  Map verseMapHindi = {};

  Map? chapterVersesEorG = {};
  void loadJson() async {
    await rootBundle
        .loadString('assets/JSON/bhagvad_gita_english.json')
        .then((value) {
      verseJsonEnglish = value;
      verseJsonMapEnglish = jsonDecode(verseJsonEnglish);
      verseMapEnglish = verseJsonMapEnglish['verses'];
      setState(() {});
    });

    await rootBundle
        .loadString('assets/JSON/bhagvad_gita_hindi.json')
        .then((value) {
      verseJsonHindi = value;
      verseJsonMapHindi = jsonDecode(verseJsonHindi);
      verseMapHindi = verseJsonMapHindi['verses'];
      setState(() {});
    });
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
    final chapterNumber = args['chapterNumber'];
    chapterVersesEorG = (language == 'english')
        ? verseMapEnglish['$chapterNumber']
        : verseMapHindi['$chapterNumber'];

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
          ),
        ),
        child: (verseMapEnglish.isEmpty || verseMapHindi.isEmpty)
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.orangeAccent,
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
                    title: Text(
                      'Chapter Number: $chapterNumber',
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
                      style: Theme.of(context).textTheme.labelSmall,
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
                            : GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      'verse_detail_page',
                                      arguments: (verse));
                                },
                                child: Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height: 35.h,
                                          width: 35.h,
                                          color: Colors.red.shade100,
                                          child: Text(
                                            '${verse['verse_number']}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30.w,
                                        ),
                                        Text(
                                          '${verse['text']}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                      },
                      childCount: chapterVersesEorG?.length ?? 0,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
