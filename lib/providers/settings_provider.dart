import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  SettingsProvider() {
    loadSettings();
  }

  late SharedPreferences prefs;

  // Theme mode ==========================================================

  late ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  bool get isDark => themeMode == ThemeMode.dark;

  // Locale ===============================================================

  String languageCode = 'en';

  Future<void> loadSettings() async {
    prefs = await SharedPreferences.getInstance();

    loadThemeMode();
  }

  // Prefs save/load ======================================================

  void loadThemeMode() {
    final bool? savedThemeMode = prefs.getBool('themeMode');
    if (savedThemeMode == null) {
      themeMode = ThemeMode.dark;
      return;
    }
    themeMode = savedThemeMode ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> setThemeMode() async {
    themeMode = isDark ? ThemeMode.light : ThemeMode.dark;
    await prefs.setBool('themeMode', isDark);
  }

  Future<void> setLanguage() async {}
}

SettingsProvider settingsProvider = SettingsProvider();
