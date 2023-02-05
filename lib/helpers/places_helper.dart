import 'dart:convert';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class PlacesHelper {
  static const String kGoogleApiKey = "AIzaSyCJvTcvYbb95bHQ_qW9AohjFW5nHwtcmkk";
  static const String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';

  static String? sessionToken;

  static Future<dynamic> getSuggestion(String input) async {
    sessionToken ??= const Uuid().v4();
    String request = '$baseURL?input=$input&key=$kGoogleApiKey&sessiontoken=$sessionToken&components=country:ua';
    Uri uri = Uri.parse(request);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['predictions'];
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  static Future<LatLng?> predictionPosition(String? placeId) async {
    if (placeId != null) {
      GoogleMapsPlaces places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse detail = await places.getDetailsByPlaceId(placeId);
      return LatLng(
        detail.result.geometry!.location.lat,
        detail.result.geometry!.location.lng,
      );
    }
    return null;
  }
}
