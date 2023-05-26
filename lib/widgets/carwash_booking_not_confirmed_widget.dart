import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carwash_app/bloc/carwash_booking_bloc.dart';
import 'package:carwash_app/bloc/carwash_booking_state.dart';
import 'package:carwash_app/models/carwash_booking.dart';
import 'package:carwash_app/models/carwash_manager.dart';
import 'package:carwash_app/widgets/rounded_button.dart';
import 'package:carwash_app/widgets/carwash_booking_cancellation_dialog.dart';

class CarwashBookingNotConfirmedWidget extends StatefulWidget {
  @override
  _CarwashBookingNotConfirmedWidgetState createState() =>
      _CarwashBookingNotConfirmedWidgetState();
}

class _CarwashBookingNotConfirmedWidgetState
    extends State<CarwashBookingNotConfirmedWidget> {
  late CarwashBooking booking;
  late CarwashManager manager;

  @override
  void initState() {
    super.initState();
    booking = (BlocProvider.of<CarwashBookingBloc>(context).state
            as CarwashNotConfirmedState)
        .booking;
    manager = (BlocProvider.of<CarwashBookingBloc>(context).state
            as CarwashNotConfirmedState)
        .manager;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                buildManager(),
                SizedBox(
                  height: 12.0,
                ),
                buildPriceDetails(),
                SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      size: 22.0,
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Expanded(
                        child: Text(
                      "Change Pickup Location",
                      style: Theme.of(context).textTheme.subhead,
                    )),
                    Text(
                      "Edit",
                      style: Theme.of(context).textTheme.title,
                    )
                  ],
                ),
                SizedBox(
                  height: 24.0,
                ),
                SizedBox(
                  height: 32.0,
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              RoundedButton(
                onTap: () {},
                iconData: Icons.call,
              ),
              SizedBox(
                width: 24.0,
              ),
              Expanded(
                flex: 2,
                child: RoundedButton(
                  text: "Cancel Booking",
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) =>
                            CarwashBookingCancellationDialog());
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildManager() {
    return Row(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.network(
            "${manager.managerPic}",
            width: 48.0,
            height: 48.0,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: 16.0,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "${manager.managerName}",
              style: Theme.of(context).textTheme.title,
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              "${manager.carwashDetails}",
              style: Theme.of(context).textTheme.subtitle,
            )
          ],
        )),
        SizedBox(
          width: 8.0,
        ),
        Container(
          decoration: BoxDecoration(
              color: Color(0xffeeeeee).withOpacity(0.5),
              borderRadius: BorderRadius.circular(12.0)),
          padding: EdgeInsets.all(6.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.star,
                color: Colors.yellow,
                size: 20.0,
              ),
              Text(
                "${manager.managerRating}",
                style: Theme.of(context).textTheme.title,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildPriceDetails() {
    return Column(
      children: <Widget>[
        Divider(),
        SizedBox(
          height: 14.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            buildIconText("21 km", Icons.directions),
            buildIconText("1-3", Icons.person_outline),
            buildIconText("\$150", Icons.monetization_on),
          ],
        ),
        SizedBox(
          height: 14.0,
        ),
        Divider()
      ],
    );
  }

  Widget buildIconText(String text, IconData iconData) {
    return Row(
      children: <Widget>[
        Icon(
          iconData,
          size: 22.0,
          color: Colors.black,
        ),
        Text(
          " $text",
          style: Theme.of(context).textTheme.title,
        )
      ],
    );
  }
}
