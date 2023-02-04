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

  String _languageCode = 'en';

  String get languageCode => _languageCode;

  set languageCode(String languageCode) {
    _languageCode = languageCode;
    notifyListeners();
  }

  // Prefs save/load ======================================================

  Future<void> loadSettings() async {
    prefs = await SharedPreferences.getInstance();

    loadThemeMode();
    loadLanguage();
  }

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

  void loadLanguage() {
    final String? language = prefs.getString('languageCode');
    if (language == null) {
      languageCode = 'en';
      return;
    }
    languageCode = language;
  }

  Future<void> setLanguage(String language) async {
    languageCode = language;
    await prefs.setString('languageCode', languageCode);
  }
}

SettingsProvider settingsProvider = SettingsProvider();
