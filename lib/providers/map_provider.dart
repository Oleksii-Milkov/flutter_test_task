import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test_task/helpers/location_helper.dart';
import 'package:flutter_test_task/providers/firebase/auth_provider.dart';
import 'package:flutter_test_task/providers/firebase/database_base.dart';
import 'package:flutter_test_task/providers/settings_provider.dart';
import 'package:flutter_test_task/providers/user_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum LocationMode { moved, standart, navigator }

class MapProvider extends ChangeNotifier with DatabaseBase {
  MapProvider() {
    loadMapStyles();
  }

  LocationHelper locationHelper = LocationHelper();

  late String darkMapStyle;
  late String lightMapStyle;

  Future loadMapStyles() async {
    darkMapStyle = await rootBundle.loadString('assets/map_styles/dark.json');
    lightMapStyle = await rootBundle.loadString('assets/map_styles/light.json');
  }

  late GoogleMapController mapController;

  LocationMode _locationMode = LocationMode.moved;

  LocationMode get locationMode => _locationMode;

  set locationMode(LocationMode locationMode) {
    _locationMode = locationMode;
    notifyListeners();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    locationHelper.initLocationTracking().whenComplete(() {
      setCurrentLocation();
      locationHelper.startPositionStream().listen((Position position) {});
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
      target: LatLng(
        locationHelper.currentPosition.latitude,
        locationHelper.currentPosition.longitude,
      ),
      zoom: 16,
    );

    mapController.animateCamera(
          CameraUpdate.newCameraPosition(cameraPosition),
        ).whenComplete(() => locationMode = LocationMode.standart);
  }
}

MapProvider mapProvider = MapProvider();
