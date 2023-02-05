import 'package:flutter/material.dart';
import 'package:flutter_test_task/generated/l10n.dart';
import 'package:flutter_test_task/helpers/language_helper.dart';
import 'package:flutter_test_task/pages/language_page/language_page.dart';
import 'package:flutter_test_task/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.settings),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Consumer<SettingsProvider>(
          builder: (context, settingsProvider, child) {
            return ListView(
              children: [
                Card(
                  child: ListTile(
                    title: Text(S.current.language),
                    leading: const Icon(Icons.language),
                    trailing: Text(
                      LanguageHelper.getCountryName(settingsProvider.languageCode),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LanguagePage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
