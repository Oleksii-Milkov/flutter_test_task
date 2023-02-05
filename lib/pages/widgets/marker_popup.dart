import 'package:flutter_test_task/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_task/helpers/location_helper.dart';
import 'package:flutter_test_task/models/remote_user.dart';
import 'package:flutter_test_task/providers/polyline_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ListTile(
                leading: CircleAvatar(
                  foregroundImage: user.photo != null
                      ? Image.network(user.photo!).image
                      : null,
                  child: const Icon(Icons.person),
                ),
                title: Text(user.name),
                subtitle: user.isOnline
                    ? Text(S.current.online)
                    : Text(S.current.lastSeen(user.shortTimeStamp)),
              ),
              Consumer<PolylineProvider>(
                builder: (context, polylineProvider, child) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: polylineProvider.polylines.containsKey(PolylineId(user.id))
                        ? TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.redAccent,
                            ),
                            onPressed: () {
                              polylineProvider.deleteRoute(user.id);
                            },
                            child: Text(S.current.deleteRoute),
                          )
                        : ElevatedButton(
                            onPressed: () async {
                              await polylineProvider.startRoute(
                                LocationHelper.currentLatLon,
                                user,
                              );
                            },
                            child: Text(S.current.buildRoute),
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
