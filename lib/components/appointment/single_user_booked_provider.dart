import 'package:flutter/material.dart';
import 'package:test_honours/components/booking_calendar/booking_service.dart';
import 'package:test_honours/db/booking_controller.dart';

class TempModel {
  final String doctorName;
  final DateTime apptStart;

  TempModel(this.doctorName, this.apptStart);
}

/// This class is used to store the user's bookings
/// temp:
class UserBooksProvider extends ChangeNotifier {
  List<TempModel> _userBookings = [];

  get bookedList => _userBookings;

  void addBooking(TempModel model) {
    _userBookings.add(model);
    notifyListeners();
  }

  void removeBooking(TempModel bookingModel) {
    _userBookings.remove(bookingModel);
    notifyListeners();
  }

  bool isBooked(BookingController controller, int index) {
    final selected = controller.allSlotsForBooking[index];
    final docName = controller.bookingModel.doctorName;
    final element = _userBookings.indexWhere((element) =>
        element.apptStart == selected &&
        element.doctorName == element.doctorName);

    return element > -1;
  }
}
