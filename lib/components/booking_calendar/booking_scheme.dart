import 'package:flutter/material.dart';

import 'package:test_honours/components/booking_calendar/single_booking_slot.dart';

class BookingSchemeAvailability extends StatelessWidget {
  const BookingSchemeAvailability({
    Key? key,
    required this.timeSlot,
    required this.isBooked,
    required this.isClicked,
    required this.isSelected,
    required this.isBreakTime,
    this.bookedSlotColor,
    this.selectedSlotColor,
    this.availableSlotColor,
    this.breakSlotColor,
    this.hideBreakSlot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (!isBooked && !isBreakTime) ? isClicked : null,
      child: BookingSlot(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          margin: EdgeInsets.only(top: 5, bottom: 25, right: 10, left: 10),
          color: identifySlotColor(),
          timeSlot: timeSlot),
    );
  }

  final Widget timeSlot;

  final bool isBreakTime;
  final bool? hideBreakSlot;
  final bool isBooked;
  final bool isSelected;

  final VoidCallback isClicked;

  final Color? bookedSlotColor;
  final Color? selectedSlotColor;
  final Color? availableSlotColor;
  final Color? breakSlotColor;

  Color identifySlotColor() {
    Color availableColor = Colors.greenAccent;
    Color bookedColor = Colors.redAccent;
    Color breakColor = Colors.grey;
    Color selectedColor = Colors.lightBlueAccent;
    if (isBreakTime == true) {
      return breakSlotColor ?? breakColor;
    }

    if (isBooked) {
      return bookedSlotColor ?? bookedColor;
    } else {
      if (isSelected) {
        return selectedSlotColor ?? selectedColor;
      } else {
        return availableSlotColor ?? availableColor;
      }
    }
  }
}
