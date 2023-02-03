import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test_task/firebase_options.dart';
import 'package:flutter_test_task/generated/l10n.dart';
import 'package:flutter_test_task/helpers/locales_helper.dart';
import 'package:flutter_test_task/pages/auth_page.dart';
import 'package:flutter_test_task/pages/home_page/home_page.dart';
import 'package:flutter_test_task/providers.dart';
import 'package:flutter_test_task/providers/firebase/auth_provider.dart';
import 'package:flutter_test_task/providers/settings_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const Providers(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) {
        return MaterialApp(
          title: 'Flutter Demo',

          // Theme mode
          themeMode: settingsProvider.themeMode,
          theme: ThemeData(
            colorScheme: const ColorScheme.light()
          ),
          darkTheme: ThemeData(
              colorScheme: const ColorScheme.dark()
          ),

          // Localization
          locale: Locale(settingsProvider.languageCode),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: LocalesHelper.localesList,

          home: Builder(builder: (context) {
            if (context.read<AuthProvider>().isAuthorized) {
              return const HomePage();
            } else {
              return const AuthPage();
            }
          }),
        );
      }
    );
  }
}
