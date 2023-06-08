import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carwash_app/bloc/carwash_booking_bloc.dart';
import 'package:carwash_app/bloc/carwash_booking_event.dart';
import 'package:carwash_app/bloc/carwash_booking_state.dart';
import 'package:carwash_app/widgets/destination_selection_widget.dart';
import 'package:carwash_app/widgets/home_app_bar.dart';
import 'package:carwash_app/widgets/home_drawer.dart';
import 'package:carwash_app/widgets/carwash_booking_confirmed_widget.dart';
import 'package:carwash_app/widgets/carwash_booking_home_widget.dart';
import 'package:carwash_app/widgets/carwash_map.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<CarwashBookingBloc>(context).add(BackPressedEvent());
        return false;
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          endDrawer: HomeDrawer(),
          body: Stack(
            children: <Widget>[CarwashMap(), HomeAppBar()],
          ),
          bottomSheet: BlocBuilder<CarwashBookingBloc, CarwashBookingState>(
              builder: (BuildContext context, CarwashBookingState state) {
            if (state is CarwashBookingNotInitializedState) {
              return Container();
            }
            if (state is CarwashBookingNotSelectedState) {
              return DestinationSelctionWidget();
            }
            if (state is CarwashBookingConfirmedState) {
              return CarwashBookingConfirmedWidget();
            }
            return CarwashBookingHomeWidget();
          }),
        ),
      ),
    );
  }
}
