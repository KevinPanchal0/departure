import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/language_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadJson();
  }

  late String chaptersJsonEnglish;

  Map chaptersJsonMapEnglish = {};
  Map chapterMapEnglish = {};

  late String chaptersJsonHindi;
  Map chaptersJsonMapHindi = {};
  Map chapterMapHindi = {};
  Map versesMap = {};
  String? randomQuoteString;
  void loadJson() async {
    chaptersJsonEnglish =
        await rootBundle.loadString('assets/JSON/bhagvad_gita_english.json');
    chaptersJsonMapEnglish = jsonDecode(chaptersJsonEnglish);
    chapterMapEnglish = chaptersJsonMapEnglish['chapters'];
    versesMap = await chaptersJsonMapEnglish['verses'];

    chaptersJsonHindi =
        await rootBundle.loadString('assets/JSON/bhagvad_gita_hindi.json');
    chaptersJsonMapHindi = jsonDecode(chaptersJsonHindi);
    chapterMapHindi = await chaptersJsonMapHindi['chapters'];
    await randomQuote();
    setState(() {});
  }

  Future<void> randomQuote() async {
    int randomChapterNumber = Random().nextInt(18);
    int index = randomChapterNumber;
    // print(index);
    // print(versesMap['$index']['1']['meaning']);
    randomQuoteString = await versesMap['$index']['1']['meaning'];
  }

  @override
  Widget build(BuildContext context) {
    final language =
        Provider.of<LanguageProvider>(context).languageModel.language;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text(
              'Srimad Bhagwad Gita',
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('setting_page');
                },
                icon: const Icon(
                  Icons.settings_outlined,
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.multiply,
                  ),
                  child: Image.asset(
                    'assets/images/krishna_bg.jpeg',
                    width: MediaQuery.of(context).size.width,
                    height: 230.h,
                    fit: BoxFit.cover,
                  ),
                ),
                (randomQuoteString == null)
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.orangeAccent,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'VERSE OF THE DAY',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          SizedBox(
                            height: 25.sp,
                          ),
                          Text(
                            randomQuoteString!,
                            style: Theme.of(context).textTheme.labelMedium,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Text(
              'Chapters',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          (chapterMapEnglish.isEmpty || chapterMapHindi.isEmpty)
              ? SliverToBoxAdapter(
                  child: Container(
                    alignment: Alignment.center,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      final chapter = (language == 'english')
                          ? chapterMapEnglish['${i + 1}']
                          : chapterMapHindi['${i + 1}'];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18.0,
                          vertical: 4.0,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              'detail_page',
                              arguments: {
                                'chapter': (language == 'english')
                                    ? chapterMapEnglish['${i + 1}']
                                    : chapterMapHindi['${i + 1}'],
                                'chapterNumber': (language == 'english')
                                    ? chapterMapEnglish['${i + 1}']
                                        ['chapter_number']
                                    : chapterMapHindi['${i + 1}']
                                        ['chapter_number'],
                              },
                            );
                          },
                          child: Card(
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    height: 25.h,
                                    width: 25.h,
                                    color: Colors.red.shade100,
                                    child: Text(
                                      "${chapter['chapter_number']}",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25.w,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${chapter['name']}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.list,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "${chapter['verses_count']}",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: (language == 'english')
                        ? chapterMapEnglish.length
                        : chapterMapHindi.length,
                  ),
                ),
        ],
      ),
    );
  }
}
