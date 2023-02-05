import 'package:flutter/material.dart';
import 'package:flutter_test_task/generated/l10n.dart';
import 'package:flutter_test_task/helpers/places_helper.dart';
import 'package:flutter_test_task/pages/home_page/widgets/menu_button.dart';
import 'package:flutter_test_task/pages/home_page/widgets/places_list.dart';
import 'package:flutter_test_task/providers/markers_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class SearchField extends StatefulWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final controller = TextEditingController();
  List<dynamic> placesList = [];

  bool focused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Theme.of(context).dialogBackgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(24.0),
            ),
          ),
          elevation: 6,
          child: Row(
            children: [
              const MenuButton(),
              Expanded(
                child: FocusScope(
                  child: Focus(
                    onFocusChange: (focus) {
                      focused = focus;
                      setState(() {});
                    },
                    child: TextField(
                      onChanged: (String value) async {
                        placesList = await PlacesHelper.getSuggestion(value);
                        setState(() {});
                      },
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: S.current.search,
                        suffixIcon: controller.text != ''
                            ? IconButton(
                                icon: const Icon(Icons.cancel),
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  controller.text = '';
                                  context.read<MarkersProvider>().removeMarker(
                                        const MarkerId('places'),
                                      );
                                  setState(() {});
                                },
                              )
                            : null,
                      ),
                      textAlignVertical: controller.text != ''
                          ? TextAlignVertical.center
                          : TextAlignVertical.top,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        focused
            ? PlacesList(
                placesList: placesList,
                controller: controller,
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
