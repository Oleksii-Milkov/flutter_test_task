import 'package:flutter/material.dart';
import 'package:flutter_test_task/generated/l10n.dart';
import 'package:flutter_test_task/helpers/location_helper.dart';
import 'package:flutter_test_task/pages/home_page/widgets/map.dart';
import 'package:flutter_test_task/pages/home_page/widgets/menu_drawer.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawer(),
      body: Stack(
        children: [
          FutureBuilder(
            future: LocationHelper.initLocation,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                switch (LocationHelper.permission) {
                  case LocationPermission.whileInUse:
                  case LocationPermission.always:
                    return const FlutterMap();
                  default:
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(S.current.permissionDenied),
                            ElevatedButton(
                              onPressed: () async {
                                await LocationHelper.initLocationTracking();
                                setState(() {});
                              },
                              child: Text(S.current.givePermission),
                            ),
                          ],
                        ),
                      ],
                    );
                }
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(
                builder: (context) {
                  return IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                      size: 36,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
