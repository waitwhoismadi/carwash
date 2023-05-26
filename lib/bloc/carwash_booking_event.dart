import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../models/google_location.dart';
import '../models/payment_method.dart';
import '../models/carwash_type.dart';

abstract class CarwashBookingEvent extends Equatable {
  CarwashBookingEvent();
}

class CarwashBookingStartEvent extends CarwashBookingEvent {
  @override
  List<Object> get props => null;
}

class DestinationSelectedEvent extends CarwashBookingEvent {
  final LatLng destination;

  DestinationSelectedEvent({@required this.destination});

  @override
  List<Object> get props => [destination];
}

class DetailsSubmittedEvent extends CarwashBookingEvent {
  final GoogleLocation source;
  final GoogleLocation destination;
  final int noOfPersons;
  final DateTime bookingTime;

  DetailsSubmittedEvent(
      {required this.source,
      required this.destination,
      required this.noOfPersons,
      required this.bookingTime});

  @override
  List<Object> get props => [source, destination, noOfPersons, bookingTime];
}

class CarwashSelectedEvent extends CarwashBookingEvent {
  final CarwashType carwashType;

  CarwashSelectedEvent({required this.carwashType});

  @override
  List<Object> get props => [carwashType];
}

class PaymentMadeEvent extends CarwashBookingEvent {
  final PaymentMethod paymentMethod;

  PaymentMadeEvent({required this.paymentMethod});

  @override
  List<Object> get props => [paymentMethod];
}

class BackPressedEvent extends CarwashBookingEvent {
  @override
  List<Object> get props => null;
}

class CarwashBookingCancelEvent extends CarwashBookingEvent {
  @override
  List<Object> get props => null;
}
