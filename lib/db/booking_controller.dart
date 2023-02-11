import 'package:flutter/material.dart';

import '../components/booking_calendar/booking_service.dart';
import '../util/booking_util.dart';

class BookingController extends ChangeNotifier {
  BookingModel bookingModel;

  BookingController({required this.bookingModel, this.breakSlots}) {
    apptStart = bookingModel.apptStart;
    apptEnd = bookingModel.apptEnd;

    breakSlots = breakSlots;
    if (apptStart!.isAfter(apptEnd!)) {
      throw "Appt start cant be after appt end";
    }
    base = apptStart!;
    calculateBookingSlots();
  }

  late DateTime base;

  DateTime? apptStart;
  DateTime? apptEnd;

  List<DateTime> _allSlotsForBooking = [];
  List<DateTime> get allSlotsForBooking => _allSlotsForBooking;

  List<DateTimeRange> mainBookedSlotsList = [];
  List<DateTimeRange>? breakSlots = [];

  int _selectedSlot = (-1);
  bool _isUploading = false;

  int get selectedSlot => _selectedSlot;
  bool get isUploading => _isUploading;

  bool successfullySynced = false;
  bool get isSynced => successfullySynced;

  void initBack() {
    _isUploading = false;
    successfullySynced = false;
  }

  int generateSlotsBasedOnDuration() {
    int availableTimeZones = 24;
    if (apptStart != null && apptEnd != null) {
      availableTimeZones =
          DateTimeRange(start: apptStart!, end: apptEnd!).duration.inHours;
    }
    return availableTimeZones;
  }

  void calculateBookingSlots() {
    allSlotsForBooking.clear();
    _allSlotsForBooking = List.generate(generateSlotsBasedOnDuration(),
        (i) => base.add(Duration(minutes: bookingModel.apptDuration) * i));
  }

  bool checkIfBooked(int slotToBeChecked) {
    DateTime currentSlotTimeZone =
        allSlotsForBooking.elementAt(slotToBeChecked);
    bool flag = false;
    for (var currentSlot in mainBookedSlotsList) {
      if (BookingUtil.checkForDoubleBooking(
          currentSlot.start,
          currentSlot.end,
          currentSlotTimeZone,
          currentSlotTimeZone
              .add(Duration(minutes: bookingModel.apptDuration)))) {
        flag = true;
        break;
      }
    }
    return flag;
  }

  bool isFullyBooked() {
    bool fullyBooked = true;
    for (var i = 0; i < allSlotsForBooking.length; i++) {
      if (!checkIfBooked(i)) {
        fullyBooked = false;
        break;
      }
    }
    return fullyBooked;
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

  Future<void> bookAppt(List<DateTimeRange> _allBookedApptsList) async {
    mainBookedSlotsList.clear();
    calculateBookingSlots();

    for (var i = 0; i < _allBookedApptsList.length; i++) {
      final item = _allBookedApptsList[i];
      mainBookedSlotsList.add(item);
    }
  }

  bool isBreakTime(DateTime slot) {
    bool flag = false;
    if (breakSlots == null) {
      return flag;
    }
    for (var singleBreakSlot in breakSlots!) {
      if (BookingUtil.checkForDoubleBooking(
          singleBreakSlot.start,
          singleBreakSlot.end,
          slot,
          slot.add(Duration(minutes: bookingModel.apptDuration)))) {
        flag = true;
        break;
      }
    }
    return flag;
  }

  BookingModel createBookingModelToDB() {
    final bookingDate = allSlotsForBooking.elementAt(selectedSlot);
    bookingModel
      ..apptStart = (bookingDate)
      ..apptEnd =
          (bookingDate.add(Duration(minutes: bookingModel.apptDuration)));
    return bookingModel;
  }
}
