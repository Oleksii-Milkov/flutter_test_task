import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test_task/providers/map_provider.dart';
import 'package:flutter_test_task/providers/settings_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class FlutterMap extends StatelessWidget {
  const FlutterMap({Key? key}) : super(key: key);

  final LatLng center = const LatLng(45.521563, -122.677433);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      zoomControlsEnabled: false,
      onMapCreated: context.read<MapProvider>().onMapCreated,
      initialCameraPosition: CameraPosition(
        target: center,
        zoom: 11.0,
      ),
    );
  }
}
