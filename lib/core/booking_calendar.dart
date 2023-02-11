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
      required this.convertStreamResultToDateTimeRanges,
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
      this.disabledDays,
      this.disabledDates,
      this.lastDay})
      : super(key: key);

  final BookingModel bookingService;

  final Stream<dynamic>? Function(
      {required DateTime start, required DateTime end}) getBookingStream;

  final List<DateTimeRange> Function({required dynamic streamResult})
      convertStreamResultToDateTimeRanges;

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

  ///The [ScrollPhysics] of the [GridView] which shows the Booking Calendar
  final ScrollPhysics? gridScrollPhysics;

  ///Display your custom loading widget while fetching data from [Stream]
  final Widget? loadingWidget;

  ///Display your custom error widget if any error recurred while fetching data from [Stream]
  final Widget? errorWidget;

  ///Display your custom  widget while uploading data to your database
  final Widget? uploadingWidget;

  ///Display your custom  widget if every slot is booked and you want to show something special
  ///not only the red slots
  final Widget? wholeDayIsBookedWidget;

  ///The pause time, where the slots won't be available
  final List<DateTimeRange>? pauseSlots;

  ///True if you want to hide your break time from the calendar, and the explanation text as well
  final bool? hideBreakTime;

  ///for localizing the calendar, String code to locale property. (intl format) See: [https://pub.dev/packages/table_calendar#locale]
  final String? locale;

  ///What is the default starting day of the week in the tablecalendar. See [https://pub.dev/documentation/table_calendar/latest/table_calendar/StartingDayOfWeek.html]
  final CalendarDays? startingDayOfWeek;

  ///The days inside this list, won't be available in the calendar. Similarly to [DateTime.weekday] property, a week starts with Monday, which has the value 1. (Sunday=7)
  ///if you pass a number which includes "Today" as well, the first and focused day in the calendar will be the first available day after today
  final List<int>? disabledDays;

  ///The last date which can be picked in the calendar, everything after this will be disabled
  final DateTime? lastDay;

  ///Concrete List of dates when the day is unavailable, eg: holiday, everything is booked or you need to close or something.
  final List<DateTime>? disabledDates;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookingController(
          bookingModel: bookingService, breakSlots: pauseSlots),
      child: BookingCalendarInterface(
        key: key,
        getBookingStream: getBookingStream,
        uploadBooking: uploadBooking,
        bookingButtonColor: bookingButtonColor,
        bookingButtonText: bookingButtonText,
        bookingExplanation: bookingExplanation,
        bookingGridChildAspectRatio: bookingGridChildAspectRatio,
        bookingGridCrossAxisCount: bookingGridCrossAxisCount,
        formatDateTime: formatDateTime,
        convertStreamResultToDateTimeRanges:
            convertStreamResultToDateTimeRanges,
        bookedSlotTextStyle: bookedSlotTextStyle,
        availableSlotTextStyle: availableSlotTextStyle,
        selectedSlotTextStyle: selectedSlotTextStyle,
        availableSlotColor: availableSlotColor,
        availableSlotText: availableSlotText,
        bookedSlotColor: bookedSlotColor,
        bookedSlotText: bookedSlotText,
        selectedSlotColor: selectedSlotColor,
        selectedSlotText: selectedSlotText,
        gridScrollPhysics: gridScrollPhysics,
        loadingWidget: loadingWidget,
        errorWidget: errorWidget,
        uploadingWidget: uploadingWidget,
        wholeDayIsBookedWidget: wholeDayIsBookedWidget,
        pauseSlotColor: pauseSlotColor,
        pauseSlotText: pauseSlotText,
        hideBreakTime: hideBreakTime,
        locale: locale,
        startingDayOfWeek: startingDayOfWeek,
        disabledDays: disabledDays,
        lastDay: lastDay,
        disabledDates: disabledDates,
      ),
    );
  }
}
