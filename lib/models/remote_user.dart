import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class RemoteUser {
  late String name;
  String? photo;
  GeoPoint? location;
  Timestamp? lastSeen;

  RemoteUser({
    required this.name,
  });

  RemoteUser.fromJson(Map<String, dynamic> json) {
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
    return DateFormat('d MMM, h:mm').format(lastSeen!.toDate());
  }
}
