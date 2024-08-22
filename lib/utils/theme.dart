import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeCustom {
  ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: Colors.deepPurple,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 25,
      ),
    ),
    iconTheme: const IconThemeData(
      size: 25,
      color: Colors.blue,
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
      labelSmall: const TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        fontSize: 25.sp,
        color: Colors.orangeAccent,
      ),
      labelMedium: TextStyle(
        fontSize: 16.sp,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        color: Colors.red,
        fontSize: 18.sp,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
      ),
    ),
  );

  ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: Colors.deepPurple,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 25,
      ),
    ),
    iconTheme: const IconThemeData(
      size: 25,
      color: Colors.blue,
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      labelSmall: const TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        fontSize: 25.sp,
        color: Colors.orangeAccent,
      ),
      labelMedium: TextStyle(
        fontSize: 16.sp,
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        color: Colors.red,
        fontSize: 20.sp,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
      ),
    ),
  );
}
