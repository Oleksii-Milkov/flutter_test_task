import 'dart:ui';

import 'package:flutter_test_task/models/language.dart';

class LanguageHelper {
  static List<Language> languagesList = [
    Language(
      locale: const Locale("en"),
      countryName: "English",
      nativeCountryName: "English",
    ),
    Language(
      locale: const Locale("uk"),
      countryName: "Ukrainian",
      nativeCountryName: "Українська",
    ),
  ];

  static String getCountryName(String languageCode) {
    Language language = languagesList.firstWhere((element) {
      return element.locale.languageCode == languageCode;
    });
    return language.nativeCountryName;
  }

  static List<Locale> get localesList {
    return languagesList.map((language) => language.locale).toList();
  }
}