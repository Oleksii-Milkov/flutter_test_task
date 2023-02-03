import 'package:flutter/material.dart';
import 'package:flutter_test_task/pages/home_page/widgets/location_button.dart';
import 'package:flutter_test_task/providers/map_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class FlutterMap extends StatelessWidget {
  const FlutterMap({Key? key}) : super(key: key);

  final LatLng center = const LatLng(48.46465263123563, 35.04695609249012);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: center,
            zoom: 12.0,
          ),
          onMapCreated: context.read<MapProvider>().onMapCreated,
          compassEnabled: false,
          zoomControlsEnabled: false,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          onCameraMoveStarted: () {
            context.read<MapProvider>().locationMode = LocationMode.moved;
          },
        ),
        const LocationButton(),
      ],
    );
  }
}
