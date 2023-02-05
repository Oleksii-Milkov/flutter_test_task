import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test_task/helpers/location_helper.dart';
import 'package:flutter_test_task/providers/firebase/database_base.dart';
import 'package:flutter_test_task/providers/settings_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum LocationMode { moved, standart, navigator }

class MapProvider extends ChangeNotifier with DatabaseBase {
  MapProvider() {
    loadMapStyles();
  }

  // Map theme ==============================================================

  late String darkMapStyle;
  late String lightMapStyle;

  Future loadMapStyles() async {
    darkMapStyle = await rootBundle.loadString('assets/map_styles/dark.json');
    lightMapStyle = await rootBundle.loadString('assets/map_styles/light.json');
  }

  // Location button state ==================================================

  LocationMode _locationMode = LocationMode.moved;

  LocationMode get locationMode => _locationMode;

  set locationMode(LocationMode locationMode) {
    _locationMode = locationMode;
    notifyListeners();
  }

  // Controller =============================================================

  late GoogleMapController mapController;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    LocationHelper.initLocation.whenComplete(() {
      setCurrentLocation();
    });
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

  void setCurrentLocation() {
    CameraPosition cameraPosition = CameraPosition(
      target: LocationHelper.currentLatLon,
      zoom: 16,
    );
    CameraUpdate cameraUpdate = CameraUpdate.newCameraPosition(cameraPosition);

    mapController.animateCamera(cameraUpdate).whenComplete(
          () => locationMode = LocationMode.standart,
        );
  }

  void animateTo(LatLng position) {
    CameraPosition cameraPosition = CameraPosition(
      target: position,
      zoom: 16,
    );
    CameraUpdate cameraUpdate = CameraUpdate.newCameraPosition(cameraPosition);

    mapController.animateCamera(cameraUpdate);
  }
}

MapProvider mapProvider = MapProvider();
