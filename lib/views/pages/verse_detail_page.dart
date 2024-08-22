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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              'Verse: ${verseInfo['verse_number']}',
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
                    : Text(
                        'TRANSLITERATION',
                        style: Theme.of(context).textTheme.labelLarge,
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
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Text(
                  'WORD MEANING',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  verseInfo['word_meanings'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Text(
                  'TRANSLATION',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                const SizedBox(
                  height: 25,
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
    );
  }
}
