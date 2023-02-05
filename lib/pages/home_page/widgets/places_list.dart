import 'package:flutter/material.dart';
import 'package:flutter_test_task/helpers/places_helper.dart';
import 'package:flutter_test_task/providers/map_provider.dart';
import 'package:flutter_test_task/providers/markers_provider.dart';
import 'package:provider/provider.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({
    Key? key,
    required this.placesList,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;
  final List<dynamic> placesList;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
        minWidth: 400,
        maxHeight: 300,
        minHeight: 0,
      ),
      child: Material(
        color: Theme.of(context).dialogBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        elevation: 6,
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                placesList.elementAt(index)['description'],
              ),
              onTap: () async {
                controller.text = placesList.elementAt(index)['description'];
                await PlacesHelper.predictionPosition(
                  placesList.elementAt(index)['place_id'],
                ).then((position) {
                  if (position != null) {
                    context.read<MarkersProvider>().addPlaceMarker(
                          position,
                          placesList.elementAt(index),
                        );
                    context.read<MapProvider>().animateTo(position);
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                });
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              height: 2.0,
            );
          },
          itemCount: placesList.length,
        ),
      ),
    );
  }
}
