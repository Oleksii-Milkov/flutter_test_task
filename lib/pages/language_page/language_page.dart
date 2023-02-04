import 'package:flutter/material.dart';
import 'package:flutter_test_task/generated/l10n.dart';
import 'package:flutter_test_task/helpers/locales_helper.dart';
import 'package:flutter_test_task/models/language.dart';
import 'package:flutter_test_task/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.language),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Card(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  Language language =
                      LocalesHelper.languagesList.elementAt(index);

                  return ListTile(
                    title: Text(language.countryName),
                    subtitle: Text(language.nativeCountryName),
                    trailing: language.locale.languageCode ==
                            context.read<SettingsProvider>().languageCode
                        ? const Icon(Icons.done)
                        : const SizedBox.shrink(),
                    onTap: () {
                      context.read<SettingsProvider>().setLanguage(
                            language.locale.languageCode,
                          );
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    indent: 16.0,
                    endIndent: 16.0,
                    height: 2.0,
                  );
                },
                itemCount: LocalesHelper.languagesList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
