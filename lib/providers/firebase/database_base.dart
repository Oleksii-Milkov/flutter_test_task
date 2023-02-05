import 'package:cloud_firestore/cloud_firestore.dart';

mixin DatabaseBase {
  final FirebaseFirestore database = FirebaseFirestore.instance;
}

