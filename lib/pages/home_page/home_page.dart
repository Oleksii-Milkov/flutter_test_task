import 'package:flutter/material.dart';
import 'package:flutter_test_task/pages/home_page/widgets/menu_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      drawer: const MenuDrawer(),
      body: const SizedBox(),
    );
  }
}
