import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_task/generated/l10n.dart';
import 'package:flutter_test_task/providers/firebase/auth_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.profile),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                User? currentUser = authProvider.firebaseAuth.currentUser;

                return Row(
                  children: [
                    CircleAvatar(
                      foregroundImage: currentUser != null
                          ? Image.network(currentUser.photoURL ?? '').image
                          : null,
                      radius: 24,
                      child: const Icon(Icons.person),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentUser?.displayName ?? 'No user name',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(currentUser?.email ?? 'No email'),
                      ],
                    ),
                  ],
                );
              },
            ),
            const Divider(height: 48.0),
          ],
        ),
      ),
    );
  }
}
