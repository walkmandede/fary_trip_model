import 'package:maplibre_gl/maplibre_gl.dart';

import 'flexible_polyline.dart';
import 'latlngz.dart';

class TripFunctions {
  static String? encodeRoute({required List<LatLng> route}) {
    String? result;
    try {
      result = FlexiblePolyline.encode(
          route.map((e) => LatLngZ(e.latitude, e.longitude)).toList(),
          6,
          ThirdDimension.ABSENT,
          6);
    } catch (e) {
      null;
    }
    return result;
  }

  static List<LatLng> decodeRoute({required String encodedString}) {
    List<LatLng> result = [];
    try {
      FlexiblePolyline.decode(encodedString).forEach((element) {
        result.add(LatLng(element.lat, element.lng));
      });
    } catch (e) {
      null;
    }
    return result;
  }

  static LatLng? covertStringToLocation({required String rawString}) {
    LatLng? result;
    try {
      List<String> rawList = rawString.split(',');
      result = LatLng(double.tryParse(rawList.first) ?? 0,
          double.tryParse(rawList.last) ?? 0);
    } catch (e) {
      null;
    }
    return result;
  }

  static String convertLocationToString({required LatLng location}) {
    return "${location.latitude},${location.longitude}";
  }

  static dynamic enumParser({
    required String rawString,
    required List<Enum> values,
  }) {
    dynamic result = values.where((element) {
      return element.name.toUpperCase() == rawString.toUpperCase();
    }).first;
    return result;
  }
}
