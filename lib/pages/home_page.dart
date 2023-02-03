import 'package:flutter/material.dart';
import 'package:flutter_test_task/pages/auth_page.dart';
import 'package:flutter_test_task/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text('Home page'),
            ElevatedButton.icon(
              onPressed: () async {
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
              icon: const Icon(Icons.exit_to_app),
              label: const Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
