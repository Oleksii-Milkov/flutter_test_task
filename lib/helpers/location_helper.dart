import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static LocationPermission? permission;

  Position currentPosition = const Position(
    latitude: 49.03775949814199,
    longitude: 31.214917631615254,
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
    timestamp: null,
  );

  Future<void> initLocationTracking() async {
    await Geolocator.getLastKnownPosition();

    await checkPermissions();
    currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Stream<Position> startPositionStream () {
    return Geolocator.getPositionStream();
  }

  static checkPermissions() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      while (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        if (kDebugMode) {
          print('Location permission denied forever');
        }
        exit(0);
      }
    }
  }
}
