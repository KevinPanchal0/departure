import 'package:departure/models/language_model.dart';
import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  LanguageModel languageModel = LanguageModel(language: 'english');

  void languageChange(String? value) {
    languageModel.language = value!;
    notifyListeners();
  }
}
