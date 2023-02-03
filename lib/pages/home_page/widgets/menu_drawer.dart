import 'package:flutter/material.dart';
import 'package:flutter_test_task/generated/l10n.dart';
import 'package:flutter_test_task/pages/auth_page.dart';
import 'package:flutter_test_task/providers/firebase/auth_provider.dart';
import 'package:flutter_test_task/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<SettingsProvider>(
                  builder: (context, settingsProvider, child) {
                    return IconButton(
                      onPressed: () async {
                        await settingsProvider.setThemeMode();
                      },
                      icon: settingsProvider.isDark
                          ? const Icon(Icons.dark_mode_outlined)
                          : const Icon(Icons.light_mode_outlined),
                    );
                  },
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(S.current.profile),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(S.current.settings),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: Text(S.current.signOut),
            onTap: () async {
              await context.read<AuthProvider>().signOut().whenComplete(() {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AuthPage(),
                  ),
                  (route) => false,
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
