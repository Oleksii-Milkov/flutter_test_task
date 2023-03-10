import 'package:flutter/material.dart';
import 'package:flutter_test_task/generated/l10n.dart';
import 'package:flutter_test_task/pages/auth_page/auth_page.dart';
import 'package:flutter_test_task/pages/profile/profile_page.dart';
import 'package:flutter_test_task/pages/settings_page/settings_page.dart';
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
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Consumer<AuthProvider>(
                      builder: (context, authProvider, child) {
                        if (authProvider.currentUser?.displayName != null) {
                          return Flexible(
                            child: Text(
                              S.current.helloUser(
                                authProvider.currentUser!.displayName!,
                              ),
                              style: const TextStyle(fontSize: 18),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
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
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(S.current.profile),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfilePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(S.current.settings),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingPage(),
                ),
              );
            },
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
