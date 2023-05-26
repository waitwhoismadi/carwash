import 'package:equatable/equatable.dart';

class CarwashManager extends Equatable {
  final String id;
  final String managerName;
  final double managerRating;
  final String carwashDetails;
  final String managerPic;

  CarwashManager(this.id, this.managerName, this.managerPic, this.managerRating,
      this.carwashDetails);

  CarwashManager.named(
      {required this.id,
      required this.managerName,
      required this.managerPic,
      required this.managerRating,
      required this.carwashDetails});

  @override
  List<Object> get props =>
      [id, managerName, managerPic, managerRating, carwashDetails];
}
