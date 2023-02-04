import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test_task/providers/firebase/database_base.dart';
import 'package:geolocator/geolocator.dart';

class UserProvider extends ChangeNotifier with DatabaseBase {
  CollectionReference get usersCollection {
    return database.collection('users');
  }

  DocumentReference usersReference(String uid) {
    return usersCollection.doc(uid);
  }

  Stream<QuerySnapshot<Object?>> get markersStream {
    return usersCollection.snapshots();
  }

  Future<void> setUserInfo(User user) async {
    Map<String, dynamic> requestBody = {
      'profile': {
        'name': user.displayName,
        'photo': user.photoURL,
      },
    };
    usersReference(user.uid).set(requestBody);
  }

  Future<void> setUserPosition(Position position, String? uid) async {
    Map<String, dynamic> requestBody = {
      'location': {
        'geoPoint': GeoPoint(
          position.latitude,
          position.longitude,
        ),
      },
    };
    if (uid != null) await usersReference(uid).update(requestBody);
  }

  Future<void> clearUserPosition(String? uid) async {
    Map<String, dynamic> requestBody = {
      'location': {
        'geoPoint': null,
      },
    };
    if (uid != null) await usersReference(uid).update(requestBody);
  }
}

UserProvider userProvider = UserProvider();
