import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'trip_enums.dart';

enum SavePlaceType {
  home,
  work,
  other
}

class FaryTripMeta {
  DateTime startDateTime;
  DateTime endDateTime;
  String userSocketId;
  String driverSocketId;
  TripState tripState;
  PickUpState pickUpState;
  TripPayment payment;
  RentType rentType;
  int platformFees;
  double serviceFees;

  FaryTripMeta(
      {required this.startDateTime,
      required this.endDateTime,
      required this.rentType,
      required this.payment,
      required this.pickUpState,
      required this.tripState,
      required this.driverSocketId,
      required this.userSocketId,
      required this.platformFees,
      required this.serviceFees});
}

class TripPayment {
  PaymentType type;
  PaymentInfo? info;

  TripPayment({required this.type, this.info});
}

class PaymentInfo {
  String id;
  String paymentMethod;
  String phone;
  String image;

  PaymentInfo(
      {required this.id,
      required this.paymentMethod,
      required this.phone,
      required this.image});
}

class FaryProfile {
  String id;
  String name;
  String? image;
  String phone;
  String? rating;

  FaryProfile(
      {required this.id,
      required this.phone,
      required this.name,
      this.image,
      this.rating});
}

class FaryVehicle {
  String carNo;
  String carModel;
  String? carColor;

  FaryVehicle({
    required this.carNo,
    required this.carModel,
    this.carColor,
  });
}

class FaryPlace {
  String title;
  String address;
  LatLng location;
  String countryName;
  String city;
  String district;
  PlaceType? type;
  SavePlaceType? savePlaceType;

  FaryPlace(
      {required this.title,
      required this.location,
      required this.address,
      required this.city,
      required this.countryName,
      required this.district,
      this.type,
      this.savePlaceType});
}

class FaryPosition {
  LatLng location;
  double heading;

  FaryPosition({required this.location, this.heading = 0});
}

class FaryLocationMeta {
  FaryPosition userPosition;
  FaryPosition driverPosition;
  FaryRoute routeD2F;
  FaryRoute routeF2T;
  List<LatLng> routeHistory;

  FaryLocationMeta(
      {required this.userPosition,
      required this.driverPosition,
      required this.routeD2F,
      required this.routeF2T,
      this.routeHistory = const []});
}

class FaryRoute {
  List<LatLng> route;
  double distanceInKm;
  int durationInSecond;

  FaryRoute(
      {this.route = const [],
      this.distanceInKm = 0,
      this.durationInSecond = 0});
}

class FaryPromotion {
  String id;
  String code;
  PromotionType type;
  int value;

  FaryPromotion(
      {required this.id,
      required this.value,
      required this.code,
      required this.type});
}

class FaryPrice {
  int grossPrice;

  FaryPrice({required this.grossPrice});
}

class FarySos {
  SosUserType type;
  String reason;
  DateTime dateTime;

  FarySos({required this.type, required this.reason, required this.dateTime});
}