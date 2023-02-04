import 'package:flutter/material.dart';
import 'package:flutter_test_task/providers/map_provider.dart';
import 'package:provider/provider.dart';

class LocationButton extends StatelessWidget {
  const LocationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).iconTheme.color,
          iconSize: 32,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Consumer<MapProvider>(
          builder: (context, mapProvider, child) {
            switch (mapProvider.locationMode) {
              case LocationMode.moved:
                return FloatingActionButton(
                  onPressed: () {
                    context.read<MapProvider>().setCurrentLocation();
                  },
                  child: const Icon(Icons.location_searching),
                );
              case LocationMode.standart:
                return FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.my_location),
                );
              case LocationMode.navigator:
                return FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.navigation),
                );
            }
          },
        ),
      ),
    );
  }
}
