import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test_task/providers/settings_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvider extends ChangeNotifier {
  MapProvider() {
    loadMapStyles();
  }

  late String darkMapStyle;
  late String lightMapStyle;

  Future loadMapStyles() async {
    darkMapStyle = await rootBundle.loadString('assets/map_styles/dark.json');
    lightMapStyle = await rootBundle.loadString('assets/map_styles/light.json');
  }

  late GoogleMapController mapController;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setMapStyle();
  }

  void setMapStyle() {
    if (settingsProvider.isDark) {
      mapController.setMapStyle(darkMapStyle);
    } else {
      mapController.setMapStyle(lightMapStyle);
    }
    settingsProvider.addListener(() {
      if (settingsProvider.isDark) {
        mapController.setMapStyle(darkMapStyle);
      } else {
        mapController.setMapStyle(lightMapStyle);
      }
    });
  }
}

MapProvider mapProvider = MapProvider();
