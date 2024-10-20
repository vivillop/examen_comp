import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      primaryColor: const Color.fromARGB(255, 119, 6, 119),
      brightness: Brightness.light,
      fontFamily: "Roboto",
      appBarTheme: const AppBarTheme(color: Color.fromARGB(255, 80, 9, 97)),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 243, 241, 244))),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 52, 16, 69)));
}
