import 'package:flutter/material.dart';

class LightTheme {
  static ThemeData get theme => ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.blueAccent,
        ),
        cardTheme: const CardTheme(
          margin: EdgeInsets.zero,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 6,
          iconSize: 32,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      );
}
