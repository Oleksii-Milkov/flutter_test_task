import 'package:flutter/material.dart';
import 'package:flutter_test_task/pages/home_page/widgets/map.dart';
import 'package:flutter_test_task/pages/home_page/widgets/menu_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawer(),
      body: Stack(
        children: [

          const FlutterMap(),
          SafeArea(
            child: Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(Icons.menu),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
