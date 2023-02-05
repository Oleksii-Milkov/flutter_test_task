import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_test_task/models/remote_user.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineProvider extends ChangeNotifier {
  static const String kGoogleApiKey = "AIzaSyCJvTcvYbb95bHQ_qW9AohjFW5nHwtcmkk";

  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};

  PointLatLng latLng2PointLatLng(LatLng position) {
    return PointLatLng(position.latitude, position.longitude);
  }

  void addPolyline(RemoteUser user) {
    if (polylines[user.id] != null) polylines.remove(user.id);
    PolylineId id = PolylineId(user.id);
    Polyline polyline = Polyline(
      polylineId: id,
      width: 2,
      color: Colors.red,
      points: polylineCoordinates,
    );
    polylines[id] = polyline;
    notifyListeners();
  }

  Future<void> startRoute(LatLng origin, RemoteUser user) async {
    if (polylineCoordinates.isNotEmpty) polylineCoordinates.clear();
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      kGoogleApiKey,
      latLng2PointLatLng(origin),
      latLng2PointLatLng(user.latLngLocation),
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    addPolyline(user);
  }

  void deleteRoute(String id) {
    polylines.remove(PolylineId(id));
    notifyListeners();
  }
}

PolylineProvider polylineProvider = PolylineProvider();
