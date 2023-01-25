import 'package:flutter/material.dart';

import 'common_card.dart';

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
    this.pauseSlotColor,
    this.hideBreakSlot,
  }) : super(key: key);

  final Widget timeSlot;

  final bool isBreakTime;
  final bool? hideBreakSlot;
  final bool isBooked;
  final bool isSelected;

  final VoidCallback isClicked;

  final Color? bookedSlotColor;
  final Color? selectedSlotColor;
  final Color? availableSlotColor;
  final Color? pauseSlotColor;

  Color identifySlotColor() {
    if (isBreakTime) {
      return pauseSlotColor ?? Colors.grey;
    }

    if (isBooked) {
      return bookedSlotColor ?? Colors.redAccent;
    } else {
      return isSelected
          ? selectedSlotColor ?? Colors.orangeAccent
          : availableSlotColor ?? Colors.greenAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return (hideBreakSlot != null && hideBreakSlot == true && isBreakTime)
        ? const SizedBox(
            height: 10,
          )
        : GestureDetector(
            onTap: (!isBooked && !isBreakTime) ? isClicked : null,
            child: CommonCard(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                color: identifySlotColor(),
                timeSlot: timeSlot),
          );
  }
}
