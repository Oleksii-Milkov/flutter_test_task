import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_task/helpers/location_helper.dart';
import 'package:flutter_test_task/pages/home_page/widgets/location_button.dart';
import 'package:flutter_test_task/providers/firebase/auth_provider.dart';
import 'package:flutter_test_task/providers/map_provider.dart';
import 'package:flutter_test_task/providers/markers_provider.dart';
import 'package:flutter_test_task/providers/polyline_provider.dart';
import 'package:flutter_test_task/providers/user_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class FlutterMap extends StatefulWidget {
  const FlutterMap({Key? key}) : super(key: key);

  @override
  State<FlutterMap> createState() => _FlutterMapState();
}

class _FlutterMapState extends State<FlutterMap> with WidgetsBindingObserver {
  final LatLng center = const LatLng(48.46465263123563, 35.04695609249012);

  late StreamSubscription<Position> positionStream;
  late StreamSubscription<QuerySnapshot<Object?>> markersStream;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        positionStream.resume();
        markersStream.resume();
        break;
      case AppLifecycleState.inactive:
        // TODO: Handle this case.
        break;
      case AppLifecycleState.paused:
        positionStream.pause();
        markersStream.pause();
        break;
      case AppLifecycleState.detached:
        // TODO: Handle this case.
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    var userProvider = context.read<UserProvider>();
    var authProvider = context.read<AuthProvider>();

    positionStream = LocationHelper.positionStream.listen((position) {
      userProvider.setUserPosition(
        position,
        authProvider.currentUser?.uid,
      );
    });

    markersStream = userProvider.markersStream.listen((event) {
      markersProvider.updateMarkers(event.docs, context);
    });

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    positionStream.cancel();
    markersStream.cancel();
    super.dispose();
  }

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
          mapToolbarEnabled: false,
          zoomControlsEnabled: false,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          markers: Set.of(
            context.watch<MarkersProvider>().markers.values,
          ),
          polylines: Set.of(
            context.watch<PolylineProvider>().polylines.values,
          ),
          onTap: (LatLng position) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onCameraMoveStarted: () {
            context.read<MapProvider>().locationMode = LocationMode.moved;
          },
        ),
        const LocationButton(),
      ],
    );
  }
}
