import 'package:flutter/material.dart';

import '../model/booking_service.dart';
import '../util/booking_util.dart';

class BookingController extends ChangeNotifier {
  BookingModel bookingModel;

  BookingController({required this.bookingModel, this.pauseSlots}) {
    apptStart = bookingModel.bookingStart;
    apptEnd = bookingModel.bookingEnd;
    pauseSlots = pauseSlots;
    if (apptStart!.isAfter(apptEnd!)) {
      throw "error";
    }
    base = apptStart!;
    calculateBookingSlots();
  }

  late DateTime base;

  DateTime? apptStart;
  DateTime? apptEnd;

  List<DateTime> _allBookingSlots = [];
  List<DateTime> get allBookingSlots => _allBookingSlots;

  List<DateTimeRange> bookedSlots = [];
  List<DateTimeRange>? pauseSlots = [];

  int _selectedSlot = (-1);
  bool _isUploading = false;

  int get selectedSlot => _selectedSlot;
  bool get isUploading => _isUploading;

  bool _successfullyUploaded = false;
  bool get isSuccessfullyUploaded => _successfullyUploaded;

  void initBack() {
    _isUploading = false;
    _successfullyUploaded = false;
  }

  void calculateBookingSlots() {
    allBookingSlots.clear();
    _allBookingSlots = List.generate(_maxServiceFitInADay(),
        (i) => base.add(Duration(minutes: bookingModel.apptDuration) * i));
  }

  bool isFullyBooked() {
    bool fullyBooked = true;
    for (var i = 0; i < allBookingSlots.length; i++) {
      if (!isSlotBooked(i)) {
        fullyBooked = false;
        break;
      }
    }
    return fullyBooked;
  }

  int _maxServiceFitInADay() {
    ///if no serviceOpening and closing was provided we will calculate with 00:00-24:00
    int openingHours = 24;
    if (apptStart != null && apptEnd != null) {
      openingHours =
          DateTimeRange(start: apptStart!, end: apptEnd!).duration.inHours;
    }

    ///round down if not the whole service would fit in the last hours
    return ((openingHours * 60) / bookingModel.apptDuration).floor();
  }

  bool isSlotBooked(int i) {
    DateTime checkSlot = allBookingSlots.elementAt(i);
    bool result = false;
    for (var slot in bookedSlots) {
      if (BookingUtil.isDoubleBooking(slot.start, slot.end, checkSlot,
          checkSlot.add(Duration(minutes: bookingModel.apptDuration)))) {
        result = true;
        break;
      }
    }
    return result;
  }

  void selectSlot(int i) {
    _selectedSlot = i;
    notifyListeners();
  }

  void resetSelectedSlot() {
    _selectedSlot = -1;
    notifyListeners();
  }

  void toggleUploading() {
    _isUploading = !_isUploading;
    notifyListeners();
  }

  Future<void> generateBookedSlots(List<DateTimeRange> data) async {
    bookedSlots.clear();
    calculateBookingSlots();

    for (var i = 0; i < data.length; i++) {
      final item = data[i];
      bookedSlots.add(item);
    }
  }

  BookingModel generateNewBookingForUploading() {
    final bookingDate = allBookingSlots.elementAt(selectedSlot);
    bookingModel
      ..bookingStart = (bookingDate)
      ..bookingEnd =
          (bookingDate.add(Duration(minutes: bookingModel.apptDuration)));
    return bookingModel;
  }

  bool isSlotInPauseTime(DateTime slot) {
    bool result = false;
    if (pauseSlots == null) {
      return result;
    }
    for (var pauseSlot in pauseSlots!) {
      if (BookingUtil.isDoubleBooking(pauseSlot.start, pauseSlot.end, slot,
          slot.add(Duration(minutes: bookingModel.apptDuration)))) {
        result = true;
        break;
      }
    }
    return result;
  }
}
