import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_task/models/remote_user.dart';
import 'package:flutter_test_task/pages/widgets/marker_popup.dart';
import 'package:flutter_test_task/providers/firebase/auth_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;
import 'dart:typed_data';

class MarkersProvider extends ChangeNotifier {
  Map<MarkerId, Marker> markers = {};

  Future<Uint8List> getBytesFromAsset({
    required String path,
    required int width,
  }) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(
      format: ui.ImageByteFormat.png,
    ))!
        .buffer
        .asUint8List();
  }

  void addMarker(RemoteUser user, BuildContext context) async {
    final Uint8List customMarker = await getBytesFromAsset(
      path: user.isOnline
          ? 'assets/images/marker.png'
          : 'assets/images/disabled_marker.png',
      width: 80,
    );

    final id = MarkerId(
      user.location!.latitude.toString() + user.location!.longitude.toString(),
    );
    final marker = Marker(
      markerId: id,
      position: LatLng(
        user.location!.latitude,
        user.location!.longitude,
      ),
      icon: BitmapDescriptor.fromBytes(customMarker),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => MarkerPopup(user: user),
          backgroundColor: Colors.transparent,
        );
      },
    );
    markers[id] = marker;
    notifyListeners();
  }

  void updateMarkers(
    List<DocumentSnapshot> documentList,
    BuildContext context,
  ) {
    //if (markers.isNotEmpty) markers.clear();
    for (var document in documentList) {
      if (document.id != authProvider.currentUser?.uid) {
        RemoteUser user = RemoteUser.fromJson(
          document.data() as Map<String, dynamic>,
        );
        if (user.location != null) addMarker(user, context);
      }
    }
    notifyListeners();
  }

  void addPlaceMarker(LatLng position, Map<String, dynamic> data) async {
    const id = MarkerId('places');
    if (markers[id] != null) removeMarker(id);

    final marker = Marker(
      markerId: id,
      position: LatLng(
        position.latitude,
        position.longitude,
      ),
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(
        title: data['description'],
        snippet: position.toString(),
      ),
    );
    markers[id] = marker;
    notifyListeners();
  }

  void removeMarker(MarkerId markerId) {
    if (markers[markerId] != null) markers.remove(markerId);
    notifyListeners();
  }
}

MarkersProvider markersProvider = MarkersProvider();
