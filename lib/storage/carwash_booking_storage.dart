import '../models/carwash_booking.dart';

class CarwashBookingStorage {
  static CarwashBooking _carwashBooking;

  static Future<void> open() async {
    _carwashBooking = CarwashBooking.named();
  }

  static Future<CarwashBooking> addDetails(
      CarwashBooking carwashBooking) async {
    _carwashBooking = _carwashBooking.copyWith(carwashBooking);
    return _carwashBooking;
  }

  static Future<CarwashBooking> getCarwashBooking() async {
    return _carwashBooking;
  }
}
