import 'package:fary_trip_model/src/trip_enums.dart';
import 'package:fary_trip_model/src/trip_functions.dart';
import 'package:fary_trip_model/src/trip_sub_models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FaryTripDetail {
  String id;
  FaryTripMeta tripMeta;
  FaryProfile user;
  FaryProfile driver;
  FaryVehicle vehicle;
  FaryPlace from;
  FaryPlace to;
  FaryLocationMeta locationMeta;
  FaryPromotion? promotion;
  FaryPrice price;
  bool xDriverSos;
  bool xUserSos;

  FaryTripDetail(
      {required this.id,
      required this.tripMeta,
      required this.user,
      required this.driver,
      required this.vehicle,
      required this.from,
      required this.to,
      required this.locationMeta,
      this.promotion,
      required this.price,
      required this.xDriverSos,
      required this.xUserSos});

  factory FaryTripDetail.fromTripJson(
      {required Map<dynamic, dynamic> tripDetail}) {
    Map tripMeta = tripDetail['tripMeta'];
    Map user = tripDetail['user'];
    Map driver = tripDetail['driver'];
    Map vehicle = tripDetail['vehicle'];
    Map from = tripDetail['from'];
    Map to = tripDetail['to'];
    Map locationMeta = tripDetail['locationMeta'];
    Map? promotion = tripDetail['promotion'];
    Map price = tripDetail['price'];
    // Iterable sosRawList = tripDetail['sosMeta'] ?? [];

    return FaryTripDetail(
        id: tripDetail['id'].toString(),
        tripMeta: FaryTripMeta(
          userSocketId: '',
          driverSocketId: '',
          startDateTime:
              DateTime.tryParse(tripMeta['startDateTime'].toString()) ??
                  DateTime(0),
          endDateTime: DateTime.tryParse(tripMeta['endDateTime'].toString()) ??
              DateTime(0),
          pickUpState: TripFunctions.enumParser(
              rawString: tripMeta['pickUpState'], values: PickUpState.values),
          tripState: tripMeta['tripState'] == null
              ? null
              : TripFunctions.enumParser(
                  rawString: tripMeta['tripState'], values: TripState.values),
          rentType: TripFunctions.enumParser(
              rawString: tripMeta['rentType'], values: RentType.values),
          payment: tripMeta['payment'] == null
              ? null
              : TripPayment(
                  type: TripFunctions.enumParser(
                      rawString: tripMeta['payment']['type'],
                      values: PaymentType.values),
                  info: tripMeta['payment']['info'] == null
                      ? null
                      : PaymentInfo(
                          id: tripMeta['payment']['info']['id'].toString(),
                          paymentMethod: tripMeta['payment']['info']
                                  ['paymentMethod']
                              .toString(),
                          phone:
                              tripMeta['payment']['info']['phone'].toString(),
                          image:
                              tripMeta['payment']['info']['image'].toString()),
                ),
          companyName: tripMeta['companyName'],
          companyImage: tripMeta['companyImage'],
          industryTeam: tripMeta['industryTeam'],
          xPackage: tripMeta['isPackage'],
          platformFees: int.tryParse(tripMeta['platformFees'].toString()) ?? 0,
          serviceFees: double.tryParse(tripMeta['serviceFees'].toString()) ?? 0,
          commercialTax: tripMeta['commercialTax'],
          rentPayType: tripMeta['rentPayType'] == null
              ? null
              : TripFunctions.enumParser(
                  rawString: tripMeta['rentPayType'],
                  values: RentPayType.values),
        ),
        user: FaryProfile(
          id: user['id'].toString(),
          name: user['name'].toString(),
          image: user['image'] == null ? null : user['image'].toString(),
          phone: user['phone'].toString(),
        ),
        driver: FaryProfile(
          id: driver['id'].toString(),
          name: driver['name'].toString(),
          image: driver['image'] == null ? null : driver['image'].toString(),
          phone: driver['phone'].toString(),
          rating: driver['rating'].toString(),
        ),
        vehicle: FaryVehicle(
          carModel: vehicle['carModel'].toString(),
          carNo: vehicle['carNo'].toString(),
          carColor: vehicle['carColor'].toString(),
        ),
        from: FaryPlace(
          title: from['title'].toString(),
          address: from['address'].toString(),
          location: TripFunctions.covertStringToLocation(
                  rawString: from['location'].toString()) ??
              const LatLng(0, 0),
          countryName: from['countryName'].toString(),
          city: from['city'].toString(),
          district: from['district'].toString(),
        ),
        to: FaryPlace(
          title: to['title'].toString(),
          address: to['address'].toString(),
          location: TripFunctions.covertStringToLocation(
                  rawString: to['location'].toString()) ??
              const LatLng(0, 0),
          countryName: to['countryName'].toString(),
          city: to['city'].toString(),
          district: to['district'].toString(),
        ),
        promotion: promotion == null
            ? null
            : FaryPromotion(
                id: promotion['id'].toString(),
                discountType: TripFunctions.enumParser(
                    rawString: promotion['discountType'],
                    values: DiscountType.values),
                code: promotion['code'].toString(),
                value: int.tryParse(promotion['value'].toString()) ?? 0,
                promotionType: TripFunctions.enumParser(
                    rawString: promotion['type'],
                    values: PromotionType.values)),
        price: FaryPrice(
            grossPrice: int.tryParse(price['grossPrice'].toString()) ?? 0),
        locationMeta: FaryLocationMeta(
          routeHistory: TripFunctions.decodeRoute(
              encodedString: locationMeta['routeHistory']),
          routeD2F: FaryRoute(
            route: TripFunctions.decodeRoute(
                encodedString: locationMeta['routeD2F']['route']),
            distanceInKm: double.tryParse(
                    locationMeta['routeD2F']['distanceInKm'].toString()) ??
                0,
            durationInSecond: int.tryParse(
                    locationMeta['routeD2F']['durationInSecond'].toString()) ??
                0,
          ),
          routeF2T: FaryRoute(
            route: TripFunctions.decodeRoute(
                encodedString: locationMeta['routeF2T']['route']),
            distanceInKm: double.tryParse(
                    locationMeta['routeF2T']['distanceInKm'].toString()) ??
                0,
            durationInSecond: int.tryParse(
                    locationMeta['routeF2T']['durationInSecond'].toString()) ??
                0,
          ),
          driverPosition: FaryPosition(
              location: TripFunctions.covertStringToLocation(
                      rawString: locationMeta['driverPosition']['location']) ??
                  const LatLng(0, 0),
              heading: double.tryParse(
                      locationMeta['driverPosition']['heading'].toString()) ??
                  0),
          userPosition: FaryPosition(
              location: TripFunctions.covertStringToLocation(
                      rawString: locationMeta['userPosition']['location']) ??
                  const LatLng(0, 0),
              heading: double.tryParse(
                      locationMeta['userPosition']['heading'].toString()) ??
                  0),
        ),
        xDriverSos: tripDetail['isDriverSOS'],
        xUserSos: tripDetail['isUserSOS']);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "tripMeta": {
        "startDateTime": tripMeta.startDateTime.toString(),
        "endDateTime": tripMeta.endDateTime.toString(),
        "userSocketId": tripMeta.userSocketId,
        "driverSocketId": tripMeta.driverSocketId,
        "pickUpState": tripMeta.pickUpState.name,
        "tripState": tripMeta.tripState!.name,
        "payment": tripMeta.rentType == RentType.cooperate
            ? null
            : {
                "type": tripMeta.payment!.type.name,
                "info": tripMeta.payment!.info == null
                    ? null
                    : {
                        "id": tripMeta.payment!.info!.id,
                        "paymentMethod": tripMeta.payment!.info!.paymentMethod,
                        "phone": tripMeta.payment!.info!.phone,
                        "image": tripMeta.payment!.info!.image
                      }
              },
        "commercialTax": tripMeta.commercialTax,
        "rentType": tripMeta.rentType.name,
        "rentPayType":
            tripMeta.rentPayType == null ? null : tripMeta.rentPayType!.name
      },
      "user": {
        "id": user.id,
        "name": user.name,
        "image": user.image,
        "phone": user.phone,
        "rating": user.rating
      },
      "driver": {
        "id": driver.id,
        "name": driver.name,
        "image": driver.image,
        "phone": driver.phone,
        "rating": driver.rating
      },
      "vehicle": {
        "carNo": vehicle.carNo,
        "carModel": vehicle.carModel,
        "carColor": vehicle.carColor
      },
      "from": {
        "title": from.title,
        "address": from.address,
        "location":
            TripFunctions.convertLocationToString(location: from.location),
        "countryName": from.countryName,
        "city": from.city,
        "district": from.district
      },
      "to": {
        "title": to.title,
        "address": to.address,
        "location":
            TripFunctions.convertLocationToString(location: to.location),
        "countryName": to.countryName,
        "city": to.city,
        "district": to.district
      },
      "locationMeta": {
        "userPosition": {
          "location": TripFunctions.convertLocationToString(
              location: locationMeta.userPosition.location),
          "heading": locationMeta.userPosition.heading
        },
        "driverPosition": {
          "location": TripFunctions.convertLocationToString(
              location: locationMeta.driverPosition.location),
          "heading": locationMeta.driverPosition.heading
        },
        "routeD2F": {
          "route":
              TripFunctions.encodeRoute(route: locationMeta.routeD2F.route),
          "distanceInKm": locationMeta.routeD2F.distanceInKm,
          "durationInSecond": locationMeta.routeD2F.durationInSecond
        },
        "routeF2T": {
          "route":
              TripFunctions.encodeRoute(route: locationMeta.routeF2T.route),
          "distanceInKm": locationMeta.routeF2T.distanceInKm,
          "durationInSecond": locationMeta.routeF2T.durationInSecond
        },
        "routeHistory":
            TripFunctions.encodeRoute(route: locationMeta.routeHistory)
      },
      "promotion": promotion == null
          ? null
          : {
              "id": promotion!.id,
              "code": promotion!.code,
              "type": promotion!.discountType.name,
              "value": promotion!.value
            },
      "price": {"grossPrice": price.grossPrice},
      'isUserSOS': xUserSos,
      'isDriverSOS': xDriverSos
    };
  }
}
