import 'package:flutter/material.dart';
import 'package:flutter_test_task/providers/map_provider.dart';
import 'package:provider/provider.dart';

class LocationButton extends StatelessWidget {
  const LocationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Consumer<MapProvider>(
        builder: (context, mapProvider, child) {
          switch (mapProvider.locationMode) {
            case LocationMode.moved:
              return FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  context.read<MapProvider>().setCurrentLocation();
                },
                child: Icon(
                  Icons.location_searching,
                  color: Theme.of(context).dialogBackgroundColor,
                ),
              );
            case LocationMode.standart:
              return FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.primary,
                onPressed: () {},
                child: Icon(
                  Icons.my_location,
                  color: Theme.of(context).dialogBackgroundColor,
                ),
              );
            case LocationMode.navigator:
              return FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.primary,
                onPressed: () {},
                child: Icon(
                  Icons.navigation,
                  color: Theme.of(context).dialogBackgroundColor,
                ),
              );
          }
        },
      ),
    );
  }
}
