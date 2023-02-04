import 'dart:async';
import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationHelper {
  static LocationPermission? permission;

  static Position currentPosition = const Position(
    latitude: 50.27,
    longitude: 30.31,
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
    timestamp: null,
  );

  static LatLng currentLatLon = position2LatLng(currentPosition);

  static LatLng position2LatLng(Position position) {
    return LatLng(
      position.latitude,
      position.longitude,
    );
  }

  static Future<void> initLocation = initLocationTracking();

  static Stream<Position> positionStream = Geolocator.getPositionStream();

  static Stream<LatLng> latLngStream = Geolocator.getPositionStream(
    locationSettings: const LocationSettings(distanceFilter: 1),
  ).map((Position position) {
    return position2LatLng(position);
  });

  static Future<void> initLocationTracking() async {
    await checkPermissions();
    await checkEnabled();
    currentPosition = await Geolocator.getCurrentPosition();
    currentLatLon = position2LatLng(currentPosition);
    positionStream.listen((Position position) {
      currentPosition = position;
      currentLatLon = position2LatLng(currentPosition);
    });
  }

  static checkPermissions() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      // while (permission == LocationPermission.denied) {
      //   permission = await Geolocator.requestPermission();
      // }
      // if (permission == LocationPermission.deniedForever) {
      //   if (kDebugMode) print('Location permission denied forever');
      //   exit(0);
      // }
    }
  }

  static checkEnabled() async {
    bool status = await Geolocator.isLocationServiceEnabled();
    if (!status) await AppSettings.openLocationSettings();
  }
}