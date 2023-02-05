import 'package:flutter/material.dart';

class Language {
  late Locale locale;
  late String countryName;
  late String nativeCountryName;

  Language({
    required this.locale,
    required this.countryName,
    required this.nativeCountryName,
  });
}