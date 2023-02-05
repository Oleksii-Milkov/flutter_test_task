import 'package:flutter/material.dart';

class DarkTheme {
  static ThemeData get theme => ThemeData(
        colorScheme: const ColorScheme.dark(),
        cardTheme: const CardTheme(
          margin: EdgeInsets.zero,
          clipBehavior: Clip.none
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
