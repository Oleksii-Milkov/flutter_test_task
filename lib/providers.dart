import 'package:flutter/material.dart';
import 'package:flutter_test_task/providers/firebase/auth_provider.dart';
import 'package:flutter_test_task/providers/map_provider.dart';
import 'package:flutter_test_task/providers/markers_provider.dart';
import 'package:flutter_test_task/providers/polyline_provider.dart';
import 'package:flutter_test_task/providers/settings_provider.dart';
import 'package:flutter_test_task/providers/user_provider.dart';
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
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => settingsProvider,
        ),
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => mapProvider,
        ),
        ChangeNotifierProvider(
          create: (_) => userProvider,
        ),
        ChangeNotifierProvider(
          create: (_) => markersProvider,
        ),
        ChangeNotifierProvider(
          create: (_) => polylineProvider,
        )
      ],
      child: child,
    );
  }
}
