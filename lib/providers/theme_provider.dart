import 'package:departure/models/theme_model.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeModel themeModel = ThemeModel(theme: 'light');

  void themeToggle(String? value) {
    themeModel.theme = value!;
    notifyListeners();
  }
}
