import 'package:flutter_test_task/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_task/models/remote_user.dart';

class MarkerPopup extends StatelessWidget {
  const MarkerPopup({Key? key, required this.user}) : super(key: key);

  final RemoteUser user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Material(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: CircleAvatar(
              foregroundImage:
                  user.photo != null ? Image.network(user.photo!).image : null,
              child: const Icon(Icons.person),
            ),
            title: Text(user.name),
            subtitle: user.isOnline
                ? Text(S.current.online)
                : Text(S.current.lastSeen(user.shortTimeStamp)),
          ),
        ),
      ),
    );
  }
}
