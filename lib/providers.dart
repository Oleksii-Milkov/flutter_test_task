import 'package:flutter/material.dart';
import 'package:flutter_test_task/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class Providers extends StatelessWidget {
  const Providers({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => authProvider,
        )
      ],
      child: child,
    );
  }
}
