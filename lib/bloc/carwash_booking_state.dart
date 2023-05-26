import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import '../models/carwash.dart';
import '../models/payment_method.dart';
import '../models/carwash_manager.dart';
import '../models/carwash_booking.dart';

abstract class CarwashBookingState extends Equatable {
  CarwashBookingState();
}

class CarwashBookingNotInitializedState extends CarwashBookingState {
  CarwashBookingNotInitializedState();
  @override
  List<Object> get props => null;
}

class CarwashBookingNotSelectedState extends CarwashBookingState {
  final List<Carwash> carwashsAvailable;

  CarwashBookingNotSelectedState({required this.carwashsAvailable});

  @override
  List<Object> get props => null;
}

class DetailsNotFilledState extends CarwashBookingState {
  final CarwashBooking booking;

  DetailsNotFilledState({required this.booking});
  @override
  List<Object> get props => [booking];
}

class CarwashNotSelectedState extends CarwashBookingState {
  final CarwashBooking booking;

  CarwashNotSelectedState({required this.booking});

  @override
  List<Object> get props => [booking];
}

class PaymentNotInitializedState extends CarwashBookingState {
  final CarwashBooking booking;
  final List<PaymentMethod> methodsAvaiable;

  PaymentNotInitializedState({
    required this.booking,
    required this.methodsAvaiable,
  });

  @override
  List<Object> get props => [booking];
}

class CarwashNotConfirmedState extends CarwashBookingState {
  final CarwashManager manager;
  final CarwashBooking booking;

  CarwashNotConfirmedState({@required this.manager, @required this.booking});

  @override
  List<Object> get props => [manager, booking];
}

class CarwashConfirmedState extends CarwashBookingState {
  final CarwashManager manager;
  final CarwashBooking booking;

  CarwashConfirmedState({@required this.manager, @required this.booking});

  @override
  List<Object> get props => [manager, booking];
}

class CarwashBookingCancelledState extends CarwashBookingState {
  @override
  List<Object> get props => null;
}

class CarwashBookingLoadingState extends CarwashBookingState {
  final CarwashBookingState state;

  CarwashBookingLoadingState({required this.state});
  @override
  List<Object> get props => [state];
}

class CarwashBookingConfirmedState extends CarwashBookingState {
  final CarwashManager manager;
  final CarwashBooking booking;

  CarwashBookingConfirmedState({required this.manager, required this.booking});
  @override
  List<Object> get props => [manager];
}
