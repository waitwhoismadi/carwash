import 'package:bloc/bloc.dart';
import 'carwash_booking_state.dart';
import 'carwash_booking_event.dart';
import '../controllers/location_controller.dart';
import '../controllers/payment_method_controller.dart';
import '../controllers/carwash_booking_controller.dart';
import '../models/google_location.dart';
import '../models/payment_method.dart';
import '../models/carwash.dart';
import '../models/carwash_booking.dart';
import '../models/carwash_manager.dart';
import '../storage/carwash_booking_storage.dart';

class CarwashBookingBloc
    extends Bloc<CarwashBookingEvent, CarwashBookingState> {
  @override
  CarwashBookingState get initialState => CarwashBookingNotInitializedState();

  @override
  Stream<CarwashBookingState> mapEventToState(
      CarwashBookingEvent event) async* {
    if (event is CarwashBookingStartEvent) {
      List<Carwash> carwashs =
          await CarwashBookingController.getCarwashsAvailable();
      yield CarwashBookingNotSelectedState(carwashsAvailable: carwashs);
    }
    if (event is DestinationSelectedEvent) {
      CarwashBookingStorage.open();
      yield CarwashBookingLoadingState(
          state: DetailsNotFilledState(booking: null));

      GoogleLocation source = await LocationController.getCurrentLocation();
      GoogleLocation destination =
          await LocationController.getLocationfromId(event.destination);
      await CarwashBookingStorage.addDetails(CarwashBooking.named(
          source: source, destination: destination, noOfPersons: 1));
      CarwashBooking carwashBooking =
          await CarwashBookingStorage.getCarwashBooking();
      yield DetailsNotFilledState(booking: carwashBooking);
    }
    if (event is DetailsSubmittedEvent) {
      yield CarwashBookingLoadingState(
          state: CarwashNotSelectedState(booking: null));
      await Future.delayed(Duration(seconds: 1));
      await CarwashBookingStorage.addDetails(CarwashBooking.named(
        source: event.source,
        destination: event.destination,
        noOfPersons: event.noOfPersons,
        bookingTime: event.bookingTime,
      ));
      CarwashBooking booking = await CarwashBookingStorage.getCarwashBooking();
      yield CarwashNotSelectedState(
        booking: booking,
      );
    }
    if (event is CarwashSelectedEvent) {
      yield CarwashBookingLoadingState(
          state:
              PaymentNotInitializedState(booking: null, methodsAvaiable: []));
      CarwashBooking prevBooking =
          await CarwashBookingStorage.getCarwashBooking();
      double price = await CarwashBookingController.getPrice(prevBooking);
      await CarwashBookingStorage.addDetails(CarwashBooking.named(
          carwashType: event.carwashType, estimatedPrice: price));
      CarwashBooking booking = await CarwashBookingStorage.getCarwashBooking();
      List<PaymentMethod> methods = await PaymentMethodController.getMethods();
      yield PaymentNotInitializedState(
          booking: booking, methodsAvaiable: methods);
    }
    if (event is PaymentMadeEvent) {
      yield CarwashBookingLoadingState(
          state:
              PaymentNotInitializedState(booking: null, methodsAvaiable: null));
      CarwashBooking booking = await CarwashBookingStorage.addDetails(
          CarwashBooking.named(paymentMethod: event.paymentMethod));
      CarwashManager carwashManager =
          await CarwashBookingController.getCarwashManager(booking);
      yield CarwashNotConfirmedState(booking: booking, manager: carwashManager);
      await Future.delayed(Duration(seconds: 1));
      yield CarwashBookingConfirmedState(
          booking: booking, manager: carwashManager);
    }
    if (event is CarwashBookingCancelEvent) {
      yield CarwashBookingCancelledState();
      await Future.delayed(Duration(milliseconds: 500));
      List<Carwash> carwashs =
          await CarwashBookingController.getCarwashsAvailable();
      yield CarwashBookingNotSelectedState(carwashsAvailable: carwashs);
    }
    if (event is BackPressedEvent) {
      switch (state.runtimeType) {
        case DetailsNotFilledState:
          List<Carwash> carwashs =
              await CarwashBookingController.getCarwashsAvailable();

          yield CarwashBookingNotSelectedState(carwashsAvailable: carwashs);
          break;
        case PaymentNotInitializedState:
          yield CarwashNotSelectedState(
              booking: (state as PaymentNotInitializedState).booking);
          break;
        case CarwashNotSelectedState:
          yield DetailsNotFilledState(
              booking: (state as CarwashNotSelectedState).booking);
          break;
      }
    }
  }
}
