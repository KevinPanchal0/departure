import 'package:departure/providers/language_provider.dart';
import 'package:departure/providers/theme_provider.dart';
import 'package:departure/utils/theme.dart';
import 'package:departure/views/pages/chapter_detail_page.dart';
import 'package:departure/views/pages/setting_page.dart';
import 'package:departure/views/pages/verse_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/pages/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).themeModel.theme;
    return MaterialApp(
      theme: ThemeCustom().lightTheme,
      darkTheme: ThemeCustom().darkTheme,
      themeMode: (theme == 'light')
          ? ThemeMode.light
          : (theme == 'dark')
              ? ThemeMode.dark
              : ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        'detail_page': (context) => const ChapterDetailPage(),
        'verse_detail_page': (context) => const VerseDetailPage(),
        'setting_page': (context) => const SettingPage(),
      },
    );
  }
}
