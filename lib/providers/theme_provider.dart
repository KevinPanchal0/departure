import 'package:departure/models/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeModel themeModel = ThemeModel(theme: 'light');

  ThemeProvider() {
    loadPrefs();
  }
  void themeToggle(String? value) {
    themeModel.theme = value!;
    setPrefs();
    notifyListeners();
  }

  Future<void> loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    themeModel.theme = prefs.getString("theme") ?? 'light';

    notifyListeners();
  }

  Future<void> setPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("theme", themeModel.theme);
  }
}
