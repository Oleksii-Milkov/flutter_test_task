import 'package:firebase_database/firebase_database.dart';

mixin DatabaseBase {
  final FirebaseDatabase database = FirebaseDatabase.instance
    ..setPersistenceEnabled(true);
}

