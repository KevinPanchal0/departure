import 'package:departure/models/language_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  LanguageModel languageModel = LanguageModel(language: 'english');

  LanguageProvider() {
    loadPrefs();
  }

  void languageChange(String? value) {
    languageModel.language = value!;
    setPrefs();
    notifyListeners();
  }

  Future<void> loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    languageModel.language = prefs.getString("language") ?? 'english';

    notifyListeners();
  }

  Future<void> setPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("language", languageModel.language);
  }
}
