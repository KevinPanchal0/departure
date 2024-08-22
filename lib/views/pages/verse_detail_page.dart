import 'package:flutter/material.dart';

class VerseDetailPage extends StatefulWidget {
  const VerseDetailPage({super.key});

  @override
  State<VerseDetailPage> createState() => _VerseDetailPageState();
}

class _VerseDetailPageState extends State<VerseDetailPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? verseInfo =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                '${verseInfo['verse_number']}',
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                verseInfo['text'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  (verseInfo['transliteration'] == null)
                      ? Container()
                      : const Text(
                          'TRANSLITERATION',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                  (verseInfo['transliteration'] == null)
                      ? Container()
                      : Text(
                          verseInfo['transliteration'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const Text(
                    'WORD MEANING',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    verseInfo['word_meanings'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const Text(
                    'TRANSLATION',
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    verseInfo['meaning'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
