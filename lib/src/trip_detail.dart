import 'package:fary_trip_model/fary_trip_model.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class FaryTripDetail {
  String id;
  FaryTripMeta tripMeta;
  FaryProfile user;
  FaryProfile driver;
  FaryVehicle vehicle;
  FaryPlace from;
  List<FaryPlace> to;
  FaryLocationMeta locationMeta;
  FaryPromotion promotionDiscount;
  FaryPromotion b2bDiscount;
  FaryPrice price;
  InsuranceInfo? insuranceInfo;
  KiloInformation kiloInformation;
  bool xDriverSos;
  bool xUserSos;
  String tripVerificationCode;
  TripType tripType;

  FaryTripDetail(
      {required this.id,
      required this.tripMeta,
      required this.user,
      required this.driver,
      required this.vehicle,
      required this.from,
      required this.to,
      required this.locationMeta,
      required this.promotionDiscount,
      required this.b2bDiscount,
      this.insuranceInfo,
      required this.price,
      required this.kiloInformation,
      required this.xDriverSos,
      required this.tripVerificationCode,
      required this.xUserSos,
      required this.tripType});

  factory FaryTripDetail.fromTripJson(
      {required Map<dynamic, dynamic> tripDetail}) {
    Map tripMeta = tripDetail['tripMeta'];
    Map user = tripDetail['user'];
    Map driver = tripDetail['driver'];
    Map vehicle = tripDetail['vehicle'];
    Map from = tripDetail['from'];
    Iterable to = (tripDetail['to'] as Iterable);
    Map locationMeta = tripDetail['locationMeta'];
    Map? promoDiscount = tripDetail['promotion'];
    Map? b2bDiscount = tripDetail['b2bPromotion'];
    Map price = tripDetail['price'];
    // Iterable sosRawList = tripDetail['sosMeta'] ?? [];

    return FaryTripDetail(
        id: tripDetail['id'].toString(),
        tripType: TripType.values.firstWhere(
          (element) =>
              element.name.toLowerCase() ==
              (tripDetail['tripType'] ?? 'normal').toString().toLowerCase(),
        ),
        tripMeta: FaryTripMeta(
          userSocketId: '',
          driverSocketId: '',
          faryDiscount: (tripMeta['faryDiscount'] == null ||
                  (int.tryParse(tripMeta['faryDiscount'].toString()) ?? 0) <= 0)
              ? FaryPromotion.defaultValue()
              : FaryPromotion(
                  id: 'farydiscount',
                  value: tripMeta['faryDiscountValue'] ?? 0,
                  code: 'faryDiscount',
                  discountType: DiscountType.values.firstWhere(
                      (element) =>
                          element.name ==
                          tripMeta['faryDiscountType'].toString().toLowerCase(),
                      orElse: () => DiscountType.mmk),
                  promotionType: PromotionType.discount,
                  b2bType: 'faryDiscount'),
          startDateTime:
              DateTime.tryParse(tripMeta['startDateTime'].toString()) ??
                  DateTime(0),
          endDateTime: DateTime.tryParse(tripMeta['endDateTime'].toString()) ??
              DateTime(0),
          waitingTime: DateTime.tryParse(tripMeta['waitingTime'].toString()),
          pickUpState: TripFunctions.enumParser(
              rawString: tripMeta['pickUpState'], values: PickUpState.values),
          tripState: tripMeta['tripState'] == null
              ? null
              : TripFunctions.enumParser(
                  rawString: tripMeta['tripState'], values: TripState.values),
          rentType: TripFunctions.enumParser(
              rawString: tripMeta['rentType'], values: RentType.values),
          xUseFaryPay: tripMeta['isFaryPay'],
          faryPayAmount: tripMeta['faryPayAmount'],
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
        tripVerificationCode: tripDetail["tripVerificationCode"] ?? '',
        insuranceInfo: tripDetail['insuranceInfo'] == null
            ? null
            : InsuranceInfo(
                logo: tripDetail['insuranceInfo']['logo'],
                xCover: tripDetail['insuranceInfo']['isCover']),
        user: FaryProfile(
          id: user['id'].toString(),
          name: user['name'].toString(),
          image: user['image'] == null ? null : user['image'].toString(),
          phone: user['phone'].toString(),
          rating: user['rating'].toString(),
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
          id: from['id'] ?? '',
          title: from['title'].toString(),
          address: from['address'].toString(),
          location: TripFunctions.covertStringToLocation(
                  rawString: from['location'].toString()) ??
              const LatLng(0, 0),
          countryName: from['countryName'].toString(),
          city: from['city'].toString(),
          district: from['district'].toString(),
        ),
        to: (to)
            .map(
              (e) => FaryPlace(
                id: e['id'] ?? '',
                title: e['title'].toString(),
                address: e['address'].toString(),
                location: TripFunctions.covertStringToLocation(
                        rawString: e['location'].toString()) ??
                    const LatLng(0, 0),
                countryName: e['countryName'].toString(),
                city: e['city'].toString(),
                district: e['district'].toString(),
              ),
            )
            .toList(),
        promotionDiscount: promoDiscount == null
            ? FaryPromotion.defaultValue()
            : FaryPromotion(
                id: promoDiscount['id'].toString(),
                discountType: DiscountType.values.firstWhere(
                    (element) =>
                        element.name ==
                        promoDiscount['discountType'].toString().toLowerCase(),
                    orElse: () => DiscountType.mmk),
                code: promoDiscount['code'].toString(),
                value: int.tryParse(promoDiscount['value'].toString()) ?? 0,
                promotionType: PromotionType.values.firstWhere(
                    (element) => element.name == promoDiscount['type'],
                    orElse: () => PromotionType.discount),
                b2bType: promoDiscount['b2bType'] ?? '',
              ),
        b2bDiscount: b2bDiscount == null
            ? FaryPromotion.defaultValue()
            : FaryPromotion(
                id: b2bDiscount['id'].toString(),
                discountType: DiscountType.values.firstWhere(
                    (element) =>
                        element.name ==
                        b2bDiscount['discountType'].toString().toLowerCase(),
                    orElse: () => DiscountType.mmk),
                code: b2bDiscount['code'].toString(),
                value: int.tryParse(b2bDiscount['value'].toString()) ?? 0,
                promotionType: PromotionType.values.firstWhere(
                    (element) => element.name == b2bDiscount['type'],
                    orElse: () => PromotionType.discount),
                b2bType: b2bDiscount['b2bType'] ?? '',
              ),
        price: FaryPrice(
            grossPrice: int.tryParse(price['grossPrice'].toString()) ?? 0,
            pickUpCharges:
                int.tryParse(price['pickUpCharges'].toString()) ?? 0),
        kiloInformation: KiloInformation(
          carType: tripDetail['carType'],
          maxKiloPrice:
              int.tryParse(tripDetail['maxKiloPrice'].toString()) ?? 0,
          minKiloPrice:
              int.tryParse(tripDetail['minKiloPrice'].toString()) ?? 0,
          currentKilo:
              double.tryParse(tripDetail['currentKilo'].toString()) ?? 0,
          currentKiloPrice:
              int.tryParse(tripDetail['currentKiloPrice'].toString()) ?? 0,
        ),
        locationMeta: FaryLocationMeta(
          routeHistory: TripFunctions.decodeRoute(
              encodedString: locationMeta['routeHistory']),
          nextDropOffIndex: locationMeta['nextDropOffIndex'],
          totalDropOff: locationMeta['totalDropOff'],
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
      "to": to.map((e) => FaryConvert.faryPlaceToMap(e)).toList(),
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
      "promotion": {
        "id": promotionDiscount.id,
        "code": promotionDiscount.code,
        "type": promotionDiscount.discountType.name,
        "value": promotionDiscount.value
      },
      "price": {"grossPrice": price.grossPrice},
      'isUserSOS': xUserSos,
      'isDriverSOS': xDriverSos
    };
  }
}
