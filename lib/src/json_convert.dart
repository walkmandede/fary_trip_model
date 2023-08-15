
import 'package:fary_trip_model/src/trip_enums.dart';
import 'package:fary_trip_model/src/trip_functions.dart';
import 'package:fary_trip_model/src/trip_sub_models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FaryConvert {
  static FaryPlace faryPlaceFromJson(Map data) {
    // print(object)
    var temp = data['position'].toString().split(',');
    print(temp);
    return FaryPlace(
        title: data['title'],
        location: LatLng(double.tryParse(temp.first.toString()) ?? 0.0,
            double.tryParse(temp.last.toString()) ?? 0.0),
        address: data['address'],
        city: data['city'],
        countryName: data['countryName'],
        district: data['district'],
        type: PlaceType.search
    );
  }

  static Map faryPlaceToMap(FaryPlace faryPlace) {
    return {
      "title": faryPlace.title,
      "address": faryPlace.address,
      "location":
          '${faryPlace.location.latitude},${faryPlace.location.longitude}',
      "countryName": faryPlace.countryName,
      "city": faryPlace.city,
      "district": faryPlace.district
    };
  }

  static FaryPromotion? faryPromotionFromJson(Map? data) {
    return data == null
        ? null
        : FaryPromotion(
            id: data['id'],
            value: data['value'],
            code: data['code'],
            type: TripFunctions.enumParser(
                rawString: data['type'], values: PromotionType.values));
  }

  static Map? faryPromotionToMap(FaryPromotion? faryPromotion) {
    return faryPromotion == null || faryPromotion.id == ''
        ? null
        : {
            "id": faryPromotion.id,
            "code": faryPromotion.code,
            "type": faryPromotion.type.name,
            "value": faryPromotion.value
          };
  }
}
