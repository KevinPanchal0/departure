import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  Map<String, dynamic> chaptersJsonMapEnglish = {};
  Map<String, dynamic> chapterMapEnglish = {};

  late String chaptersJsonHindi;
  Map<String, dynamic> chaptersJsonMapHindi = {};
  Map<String, dynamic> chapterMapHindi = {};

  void loadJson() async {
    chaptersJsonEnglish =
        await rootBundle.loadString('assets/JSON/bhagvad_gita_english.json');
    chaptersJsonMapEnglish = jsonDecode(chaptersJsonEnglish);
    chapterMapEnglish = chaptersJsonMapEnglish['chapters'];

    chaptersJsonHindi =
        await rootBundle.loadString('assets/JSON/bhagvad_gita_hindi.json');
    chaptersJsonMapHindi = jsonDecode(chaptersJsonHindi);
    chapterMapHindi = chaptersJsonMapHindi['chapters'];

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final language =
        Provider.of<LanguageProvider>(context).languageModel.language;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: (chapterMapEnglish.isEmpty || chapterMapHindi.isEmpty)
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.deepPurple,
                  title: const Text(
                    'Srimad Bhagwad Gita',
                    style: TextStyle(color: Colors.white),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('setting_page');
                      },
                      icon: const Icon(
                        Icons.settings_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      'Chapters',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      final chapter = (language == 'english')
                          ? chapterMapEnglish['${i + 1}']
                          : chapterMapHindi['${i + 1}'];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Container(
                            alignment: Alignment.center,
                            height: 25,
                            width: 25,
                            color: Colors.red.shade100,
                            child: Text(
                              "${chapter['chapter_number']}",
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          title: Text(
                            "${chapter['name']}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              const Icon(
                                Icons.list,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${chapter['verses_count']}",
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                'detail_page',
                                arguments: {
                                  'chapter': chapter,
                                  'chapterNumber': chapter['chapter_number'],
                                },
                              );
                            },
                            icon: const Icon(Icons.chevron_right),
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              'detail_page',
                              arguments: {
                                'chapter': chapter,
                                'chapterNumber': chapter['chapter_number'],
                              },
                            );
                          },
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
