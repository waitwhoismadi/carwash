import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carwash_app/bloc/carwash_booking_bloc.dart';
import 'package:carwash_app/bloc/carwash_booking_state.dart';
import 'package:carwash_app/models/carwash_booking.dart';
import 'package:carwash_app/models/carwash_manager.dart';
import 'package:carwash_app/widgets/carwash_booking_cancellation_dialog.dart';

class CarwashBookingConfirmedWidget extends StatefulWidget {
  @override
  _CarwashBookingConfirmedWidgetState createState() =>
      _CarwashBookingConfirmedWidgetState();
}

class _CarwashBookingConfirmedWidgetState
    extends State<CarwashBookingConfirmedWidget>
    with TickerProviderStateMixin<CarwashBookingConfirmedWidget> {
  late AnimationController animationController;
  late Animation animation;
  late CarwashManager manager;
  late CarwashBooking booking;
  @override
  void initState() {
    super.initState();
    booking = (BlocProvider.of<CarwashBookingBloc>(context).state
            as CarwashBookingConfirmedState)
        .booking;
    manager = (BlocProvider.of<CarwashBookingBloc>(context).state
            as CarwashBookingConfirmedState)
        .manager;
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    animation = CurvedAnimation(
      curve: Curves.easeIn,
      parent: animationController,
    );
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0)),
                    child: Container(
                      color: Colors.black,
                      padding: EdgeInsets.symmetric(
                          vertical: 28.0, horizontal: 28.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Ride Info",
                              style: Theme.of(context)
                                  .textTheme
                                  .title
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        CarwashBookingCancellationDialog());
                              },
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    )),
                Container(
                  color: Colors.black,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0)),
                    child: Container(
                      padding: EdgeInsets.all(24.0),
                      color: Colors.white,
                      child: buildManager(),
                    ),
                  ),
                )
              ]),
        ),
        builder: (context, child) {
          return Container(
            height: 200.0 * animation.value,
            child: child,
          );
        });
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
}
