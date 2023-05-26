import '../models/payment_method.dart';

import 'google_location.dart';
import 'carwash_type.dart';

class CarwashBooking {
  final String id;
  final GoogleLocation source;
  final GoogleLocation destination;
  final int noOfPersons;
  final DateTime bookingTime;
  final CarwashType taxiType;
  final double estimatedPrice;
  final PaymentMethod paymentMethod;
  final String promoApplied;

  CarwashBooking(
      this.id,
      this.source,
      this.destination,
      this.noOfPersons,
      this.bookingTime,
      this.taxiType,
      this.estimatedPrice,
      this.paymentMethod,
      this.promoApplied);

  CarwashBooking.named({
    required this.id,
    required this.source,
    required this.destination,
    required this.noOfPersons,
    required this.bookingTime,
    required this.taxiType,
    required this.estimatedPrice,
    required this.paymentMethod,
    required this.promoApplied,
  });

  CarwashBooking copyWith(CarwashBooking booking) {
    return CarwashBooking.named(
        id: booking.id,
        source: booking.source,
        destination: booking.destination,
        noOfPersons: booking.noOfPersons,
        bookingTime: booking.bookingTime,
        paymentMethod: booking.paymentMethod,
        promoApplied: booking.promoApplied,
        estimatedPrice: booking.estimatedPrice,
        taxiType: booking.taxiType);
  }
}
