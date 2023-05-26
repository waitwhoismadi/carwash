import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carwash_app/bloc/carwash_booking_bloc.dart';
import 'package:carwash_app/bloc/carwash_booking_event.dart';

class CarwashBookingCancellationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Cancel Ride"),
      content: Text("Do you want to cancel ride?"),
      actions: <Widget>[
        FlatButton(
          child: Text(
            "Cancel",
            style: TextStyle(fontSize: 16.0),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(
            "Ok",
            style: TextStyle(fontSize: 16.0),
          ),
          onPressed: () {
            BlocProvider.of<CarwashBookingBloc>(context)
                .add(CarwashBookingCancelEvent());
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
