import 'package:carwash_app/models/carwash.dart';
import 'package:carwash_app/models/carwash_type.dart';

class CarwashController {
  static Future<List<Carwash>> getCarwashs() async {
    return [
      Carwash.named(
          plateNo: "",
          isAvailable: true,
          carwashType: CarwashType.Standard,
          id: "1",
          title: "Standard"),
      Carwash.named(
          plateNo: "",
          isAvailable: true,
          carwashType: CarwashType.Premium,
          id: "2",
          title: "Premium"),
      Carwash.named(
          plateNo: "",
          isAvailable: true,
          carwashType: CarwashType.Platinum,
          id: "3",
          title: "Standard"),
    ];
  }
}
