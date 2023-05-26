import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controllers/location_controller.dart';
import '../models/google_location.dart';
import '../models/carwash.dart';
import '../models/carwash_booking.dart';
import '../models/carwash_manager.dart';

class CarwashBookingController {
  static Future<double> getPrice(CarwashBooking carwashBooking) async {
    return 150;
  }

  static Future<CarwashManager> getCarwashManager(
      CarwashBooking booking) async {
    return CarwashManager.named(
        managerPic:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Sidhu_in_Punjab.jpg/440px-Sidhu_in_Punjab.jpg",
        managerName: "Ram kapoor",
        managerRating: 4.5,
        carwashDetails: "Toyota (BFD823-434)");
  }

  static Future<List<Carwash>> getCarwashsAvailable() async {
    GoogleLocation location = await LocationController.getCurrentLocation();
    const double maxRadius = 200 / 111300;
    Random random = Random();
    List<Carwash> carwashs = List<Carwash>.generate(10, (index) {
      double u = random.nextDouble();
      double v = random.nextDouble();
      double w = maxRadius + sqrt(u);
      double t = 2 * pi * v;
      double x1 = w * cos(t);
      double y1 = w * sin(t);
      x1 = x1 / cos(y1);
      LatLng oldPos = location.position;
      return Carwash.named(
          id: "$index",
          position: LatLng(x1 + oldPos.latitude, y1 + oldPos.longitude),
          title: "Carwash $index");
    });
    return carwashs;
  }
}
