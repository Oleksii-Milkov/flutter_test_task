import 'package:flutter/material.dart';
import 'package:flutter_test_task/generated/l10n.dart';
import 'package:flutter_test_task/pages/home_page/home_page.dart';
import 'package:flutter_test_task/providers/firebase/auth_provider.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(
              size: 180,
            ),
            const SizedBox(height: 48),
            ElevatedButton.icon(
              onPressed: () async {
                await context.read<AuthProvider>().signInWithGoogle().whenComplete(() {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomePage(),
                    ),
                    (route) => false,
                  );
                });
              },
              icon: const Icon(Icons.account_circle),
              label: Text(S.current.signInWithGoogle),
            ),
          ],
        ),
      ),
    );
  }
}
