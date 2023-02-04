import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test_task/firebase_options.dart';
import 'package:flutter_test_task/generated/l10n.dart';
import 'package:flutter_test_task/helpers/locales_helper.dart';
import 'package:flutter_test_task/pages/auth_page/auth_page.dart';
import 'package:flutter_test_task/pages/home_page/home_page.dart';
import 'package:flutter_test_task/providers.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<SettingsProvider, String>(selector: (context, settings) {
      return settings.languageCode;
    }, shouldRebuild: (oldLanguageCode, newLanguageCode) {
      if (newLanguageCode != oldLanguageCode) {
        rebuildAllChildren(context);
        return true;
      }
      return false;
    }, builder: (context, languageCode, child) {
      return Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          return MaterialApp(
            title: 'Flutter Demo',

            // Theme mode
            themeMode: settingsProvider.themeMode,
            theme: ThemeData(
              colorScheme: const ColorScheme.light(primary: Colors.blueAccent),
              cardTheme: const CardTheme(
                margin: EdgeInsets.zero,
              ),
            ),
            darkTheme: ThemeData(
              colorScheme: const ColorScheme.dark(),
              cardTheme: const CardTheme(
                margin: EdgeInsets.zero,
              ),
            ),

            // Localization
            locale: Locale(languageCode),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: LocalesHelper.localesList,

            home: Builder(
              builder: (context) {
                if (FirebaseAuth.instance.currentUser != null) {
                  return const HomePage();
                } else {
                  return const AuthPage();
                }
              },
            ),
          );
        },
      );
    });
  }
}
