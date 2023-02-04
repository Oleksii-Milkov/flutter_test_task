import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_task/providers/firebase/auth_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkersProvider extends ChangeNotifier {
  Map<MarkerId, Marker> markers = {};

  void addMarker(double lat, double lng, BuildContext context) {
    final id = MarkerId(lat.toString() + lng.toString());
    final marker = Marker(
      markerId: id,
      position: LatLng(lat, lng),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      onTap: () {
        showModalBottomSheet(context: context, builder: (_){
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: const [
                Text('Hello'),
              ],
            ),
          );
        });
      }
    );
    markers[id] = marker;
    notifyListeners();
  }

  void updateMarkers(
    List<DocumentSnapshot> documentList,
    BuildContext context,
  ) {
    if (markers.isNotEmpty) markers.clear();
    for (var document in documentList) {
      if (document.id != authProvider.currentUser?.uid) {
        Map<String, dynamic> snapData = document.data() as Map<String, dynamic>;
        final GeoPoint point = snapData['location']['geoPoint'];
        addMarker(point.latitude, point.longitude, context);
      }
    }
    notifyListeners();
  }
}

MarkersProvider markersProvider = MarkersProvider();
