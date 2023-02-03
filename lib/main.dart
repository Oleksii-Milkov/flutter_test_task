import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_task/firebase_options.dart';
import 'package:flutter_test_task/pages/auth_page.dart';
import 'package:flutter_test_task/pages/home_page.dart';
import 'package:flutter_test_task/providers.dart';
import 'package:flutter_test_task/providers/auth_provider.dart';
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Builder(builder: (context) {
        if (context.read<AuthProvider>().isAuthorized) {
          return const HomePage();
        } else {
          return const AuthPage();
        }
      }),
    );
  }
}
