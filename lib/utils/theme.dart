import 'package:flutter/material.dart';

class ThemeCustom {
  ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color(0xff6482AD),
  );
  ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color.fromRGBO(20, 80, 14, 171),
  );
}
