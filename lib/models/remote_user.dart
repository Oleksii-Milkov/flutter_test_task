import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class RemoteUser {
  late String id;
  late String name;
  String? photo;
  GeoPoint? location;
  Timestamp? lastSeen;

  RemoteUser({
    required this.name,
  });

  RemoteUser.fromJson(this.id, Map<String, dynamic> json) {
    if (json['profile'] != null) {
      name = json['profile']['name'];
      photo = json['profile']['photo'];
    }
    if (json['location'] != null) {
      location = json['location']['geoPoint'];
      lastSeen = json['location']['lastSeen'];
    }
  }

  bool get isOnline {
    if (lastSeen != null) {
      if (DateTime.now().millisecondsSinceEpoch -
              lastSeen!.millisecondsSinceEpoch >=
          10000) {
        return false;
      }
    }
    return true;
  }

  String get shortTimeStamp {
    return DateFormat('d MMM, HH:mm').format(lastSeen!.toDate());
  }

  LatLng get latLngLocation => LatLng(location!.latitude, location!.longitude);
}
