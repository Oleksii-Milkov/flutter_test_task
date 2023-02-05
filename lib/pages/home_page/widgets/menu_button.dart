import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Builder(
        builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            style: IconButton.styleFrom(
              maximumSize: const Size(40, 40),
            ),
            icon: const Icon(
              Icons.menu,
              size: 32,
            ),
          );
        },
      ),
    );
  }
}
