import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'carwash_type.dart';

class Carwash extends Equatable {
  final String id;
  final String title;
  final bool isAvailable;
  final String plateNo;
  final CarwashType carwashType;
  final LatLng position;

  Carwash(this.id, this.title, this.isAvailable, this.plateNo, this.carwashType,
      this.position);

  Carwash.named({
    required this.id,
    required this.title,
    required this.isAvailable,
    required this.plateNo,
    required this.carwashType,
    required this.position,
  });

  @override
  List<Object> get props => [title, isAvailable, plateNo, carwashType];
}
