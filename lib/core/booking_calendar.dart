import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/booking_calendar/booking_widget_interface.dart';
import '../components/booking_calendar/booking_service.dart';
import '../model/enums.dart';
import '../db/booking_controller.dart';

class BookingCalendar extends StatelessWidget {
  const BookingCalendar(
      {Key? key,
      required this.bookingService,
      required this.getBookingStream,
      required this.uploadBooking,
      this.bookingExplanation,
      this.bookingGridCrossAxisCount,
      this.bookingGridChildAspectRatio,
      this.formatDateTime,
      this.bookingButtonText,
      this.bookingButtonColor,
      this.bookedSlotColor,
      this.selectedSlotColor,
      this.availableSlotColor,
      this.bookedSlotText,
      this.selectedSlotText,
      this.availableSlotText,
      this.availableSlotTextStyle,
      this.selectedSlotTextStyle,
      this.bookedSlotTextStyle,
      this.gridScrollPhysics,
      this.loadingWidget,
      this.errorWidget,
      this.uploadingWidget,
      this.wholeDayIsBookedWidget,
      this.pauseSlotColor,
      this.pauseSlotText,
      this.pauseSlots,
      this.hideBreakTime,
      this.locale,
      this.startingDayOfWeek = CalendarDays.monday,
      this.lastDay})
      : super(key: key);

  final BookingModel bookingService;

  final Stream<dynamic>? Function(
      {required DateTime start, required DateTime end}) getBookingStream;

  final Future<dynamic> Function({required BookingModel newBooking})
      uploadBooking;

  final Widget? bookingExplanation;

  final int? bookingGridCrossAxisCount;

  final double? bookingGridChildAspectRatio;

  final String Function(DateTime dt)? formatDateTime;

  final String? bookingButtonText;

  final Color? bookingButtonColor;

  final Color? bookedSlotColor;
  final Color? selectedSlotColor;
  final Color? availableSlotColor;
  final Color? pauseSlotColor;
  final String? bookedSlotText;
  final String? selectedSlotText;
  final String? availableSlotText;
  final String? pauseSlotText;
  final TextStyle? bookedSlotTextStyle;
  final TextStyle? availableSlotTextStyle;
  final TextStyle? selectedSlotTextStyle;

  final ScrollPhysics? gridScrollPhysics;

  final Widget? loadingWidget;

  final Widget? errorWidget;

  final Widget? uploadingWidget;

  final Widget? wholeDayIsBookedWidget;

  final List<DateTimeRange>? pauseSlots;

  final bool? hideBreakTime;

  final String? locale;

  final CalendarDays? startingDayOfWeek;

  final DateTime? lastDay;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookingController(
          bookingModel: bookingService, breakSlots: pauseSlots),
      child: BookingCalendarInterface(
        key: key,
        getBookingStream: getBookingStream,
        uploadBooking: uploadBooking,
        buttonColor: bookingButtonColor,
        bookingExplanation: bookingExplanation,
        numberOfRows: bookingGridCrossAxisCount,
        formatTimeSlotDate: formatDateTime,
        bookedSlotTextStyle: bookedSlotTextStyle,
        availableSlotTextStyle: availableSlotTextStyle,
        selectedSlotTextStyle: selectedSlotTextStyle,
        availableSlotColor: availableSlotColor,
        freeText: availableSlotText,
        bookedSlotColor: bookedSlotColor,
        bookedSlotText: bookedSlotText,
        clickedSlotColor: selectedSlotColor,
        clickedText: selectedSlotText,
        ifErrorOccursWidget: errorWidget,
        wholeDayIsBookedWidget: wholeDayIsBookedWidget,
        breakSlotColor: pauseSlotColor,
        breakText: pauseSlotText,
        timeZoneFormat: locale,
        firstWorkingDay: startingDayOfWeek,
      ),
    );
  }
}
