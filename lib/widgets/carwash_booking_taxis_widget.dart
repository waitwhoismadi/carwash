import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carwash_app/bloc/carwash_booking_bloc.dart';
import 'package:carwash_app/bloc/carwash_booking_event.dart';
import 'package:carwash_app/bloc/carwash_booking_state.dart';
import 'package:carwash_app/models/carwash_booking.dart';
import 'package:carwash_app/models/carwash_type.dart';
import 'package:carwash_app/widgets/rounded_button.dart';

class CarwashBookingCarwashsWidget extends StatefulWidget {
  @override
  _CarwashBookingCarwashsWidgetState createState() =>
      _CarwashBookingCarwashsWidgetState();
}

class _CarwashBookingCarwashsWidgetState
    extends State<CarwashBookingCarwashsWidget> {
  CarwashBooking carwashBooking;
  final List<CarwashType> carwashTypes = [
    CarwashType.Standard,
    CarwashType.Premium,
    CarwashType.Platinum
  ];
  @override
  void initState() {
    super.initState();
    carwashBooking = (BlocProvider.of<CarwashBookingBloc>(context).state
            as CarwashNotSelectedState)
        .booking;
    selectedCarwashType = carwashBooking.carwashType;
    if (selectedCarwashType == null) {
      selectedCarwashType = CarwashType.Standard;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Choose Carwash",
                    style: Theme.of(context).textTheme.headline,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  buildCarwashs(),
                  buildPriceDetails(),
                  SizedBox(
                    height: 16.0,
                  ),
                  buildLocation(carwashBooking.source.areaDetails, "From"),
                  SizedBox(
                    height: 12.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Divider(),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  buildLocation(carwashBooking.destination.areaDetails, "To"),
                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              RoundedButton(
                onTap: () {
                  BlocProvider.of<CarwashBookingBloc>(context)
                      .add(BackPressedEvent());
                },
                iconData: Icons.keyboard_backspace,
              ),
              SizedBox(
                width: 18.0,
              ),
              Expanded(
                flex: 2,
                child: RoundedButton(
                  text: "Request Trip",
                  onTap: () {
                    BlocProvider.of<CarwashBookingBloc>(context).add(
                        CarwashSelectedEvent(carwashType: selectedCarwashType));
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  CarwashType selectedCarwashType;

  Widget buildCarwashs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: carwashTypes
          .map((val) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCarwashType = val;
                  });
                },
                child: Opacity(
                  opacity: val == selectedCarwashType ? 1.0 : 0.5,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image.asset(
                            "images/carwash.jpg",
                            height: MediaQuery.of(context).size.width / 6,
                            width: MediaQuery.of(context).size.width / 6,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          val.toString().replaceFirst("CarwashType.", ""),
                          style: Theme.of(context).textTheme.title,
                        ),
                      ],
                    ),
                  ),
                ),
              ))
          .toList(),
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

  Widget buildLocation(String area, String label) {
    return Row(
      children: <Widget>[
        Text(
          "•",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
        ),
        SizedBox(
          width: 12.0,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "$label",
                style: TextStyle(fontSize: 14.0, color: Colors.black38),
              ),
              Text(
                "$area",
                style: Theme.of(context).textTheme.title,
              )
            ],
          ),
        )
      ],
    );
  }
}
