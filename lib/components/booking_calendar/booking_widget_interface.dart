import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:table_calendar/table_calendar.dart' as tc
    show StartingDayOfWeek;

import '../../db/booking_controller.dart';
import 'booking_service.dart';
import '../../model/enums.dart' as bc;
import '../../util/booking_util.dart';
import '../booking_calendar/single_booking_slot.dart';
import '../booking_calendar/booking_button.dart';
import '../booking_calendar/booking_scheme.dart';
import '../booking_calendar/booking_legend.dart';

class BookingCalendarInterface extends StatefulWidget {
  const BookingCalendarInterface({
    Key? key,
    required this.getBookingStream,
    required this.convertStreamResultToDateTimeRanges,
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
    this.bookedSlotTextStyle,
    this.selectedSlotText,
    this.selectedSlotTextStyle,
    this.availableSlotText,
    this.availableSlotTextStyle,
    this.gridScrollPhysics,
    this.loadingWidget,
    this.errorWidget,
    this.uploadingWidget,
    this.wholeDayIsBookedWidget,
    this.pauseSlotColor,
    this.pauseSlotText,
    this.hideBreakTime = false,
    this.locale,
    this.startingDayOfWeek,
    this.disabledDays,
    this.disabledDates,
    this.lastDay,
  }) : super(key: key);

  final Stream<dynamic>? Function(
      {required DateTime start, required DateTime end}) getBookingStream;
  final Future<dynamic> Function({required BookingModel newBooking})
      uploadBooking;
  final List<DateTimeRange> Function({required dynamic streamResult})
      convertStreamResultToDateTimeRanges;

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

  final bool? hideBreakTime;
  final DateTime? lastDay;
  final String? locale;
  final bc.CalendarDays? startingDayOfWeek;
  final List<int>? disabledDays;
  final List<DateTime>? disabledDates;

  final Widget? wholeDayIsBookedWidget;

  @override
  State<BookingCalendarInterface> createState() =>
      _BookingCalendarInterfaceState();
}

class _BookingCalendarInterfaceState extends State<BookingCalendarInterface> {
  late BookingController controller;
  final now = DateTime.now();

  @override
  void initState() {
    super.initState();
    controller = context.read<BookingController>();
    final firstDay = calculateFirstDay();

    startOfDay = firstDay.startOfDayAppt(controller.apptStart!);
    endOfDay = firstDay.endOfDayAppt(controller.apptEnd!);
    _focusedDay = firstDay;
    _selectedDay = firstDay;
  }

  CalendarFormat _calendarFormat = CalendarFormat.month;

  late DateTime _selectedDay;
  late DateTime _focusedDay;
  late DateTime startOfDay;
  late DateTime endOfDay;

  void selectNewDateRange() {
    startOfDay = _selectedDay.startOfDayAppt(controller.apptStart!);
    endOfDay = _selectedDay
        .add(const Duration(days: 1))
        .endOfDayAppt(controller.apptEnd!);

    controller.base = startOfDay;
    controller.resetSelectedSlot();
  }

  DateTime calculateFirstDay() {
    final now = DateTime.now();
    if (widget.disabledDays != null) {
      return widget.disabledDays!.contains(now.weekday)
          ? now.add(Duration(days: getFirstMissingDay(now.weekday)))
          : now;
    } else {
      return DateTime.now();
    }
  }

  int getFirstMissingDay(int now) {
    for (var i = 1; i <= 5; i++) {
      if (!widget.disabledDays!.contains(now + i)) {
        return i;
      }
    }
    return -1;
  }

  @override
  Widget build(BuildContext context) {
    controller = context.watch<BookingController>();

    return Consumer<BookingController>(
      builder: (_, controller, __) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
            BookingSlot(
              timeSlot: TableCalendar(
                startingDayOfWeek: widget.startingDayOfWeek?.toTC() ??
                    tc.StartingDayOfWeek.monday,
                locale: widget.locale,
                firstDay: calculateFirstDay(),
                lastDay: widget.lastDay ??
                    DateTime.now().add(const Duration(days: 80)),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                calendarStyle: const CalendarStyle(isTodayHighlighted: true),
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    selectNewDateRange();
                  }
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
            ),
            const SizedBox(height: 8),
            widget.bookingExplanation ??
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8.0,
                  runSpacing: 5.0,
                  direction: Axis.horizontal,
                  children: [
                    BookingLegend(
                        legendIconColor:
                            widget.availableSlotColor ?? Colors.greenAccent,
                        legendText: widget.availableSlotText ?? "Available"),
                    BookingLegend(
                        legendIconColor:
                            widget.selectedSlotColor ?? Colors.lightBlueAccent,
                        legendText: widget.selectedSlotText ?? "Selected"),
                    BookingLegend(
                        legendIconColor:
                            widget.bookedSlotColor ?? Colors.redAccent,
                        legendText: widget.bookedSlotText ?? "Booked"),
                    if (widget.hideBreakTime != null &&
                        widget.hideBreakTime == false)
                      BookingLegend(
                          legendIconColor: widget.pauseSlotColor ?? Colors.grey,
                          legendText: widget.pauseSlotText ?? "Break"),
                  ],
                ),
            const SizedBox(height: 8),
            //passing the data into the db
            StreamBuilder<dynamic>(
              stream: widget.getBookingStream(start: startOfDay, end: endOfDay),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return widget.errorWidget ??
                      Center(
                        child: Text(snapshot.error.toString()),
                      );
                }

                if (!snapshot.hasData) {
                  return widget.loadingWidget ??
                      const Center(child: CircularProgressIndicator());
                }

                final data = snapshot.requireData;
                controller.bookAppt(widget.convertStreamResultToDateTimeRanges(
                    streamResult: data));

                return Expanded(
                  child: (widget.wholeDayIsBookedWidget != null &&
                          controller.isFullyBooked())
                      ? widget.wholeDayIsBookedWidget!
                      : GridView.builder(
                          physics: widget.gridScrollPhysics ??
                              const BouncingScrollPhysics(),
                          itemCount: controller.allSlotsForBooking.length,
                          itemBuilder: (context, index) {
                            TextStyle? getTextStyle() {
                              if (controller.checkIfBooked(index)) {
                                return widget.bookedSlotTextStyle;
                              } else if (index == controller.selectedSlot) {
                                return widget.selectedSlotTextStyle;
                              } else {
                                return widget.availableSlotTextStyle;
                              }
                            }

                            final slot =
                                controller.allSlotsForBooking.elementAt(index);
                            return BookingSchemeAvailability(
                              hideBreakSlot: widget.hideBreakTime,
                              breakSlotColor: widget.pauseSlotColor,
                              availableSlotColor: widget.availableSlotColor,
                              bookedSlotColor: widget.bookedSlotColor,
                              selectedSlotColor: widget.selectedSlotColor,
                              isBreakTime: controller.isBreakTime(slot),
                              isBooked: controller.checkIfBooked(index),
                              isSelected: index == controller.selectedSlot,
                              isClicked: () => controller.selectSlot(index),
                              timeSlot: Center(
                                child: Text(
                                  widget.formatDateTime?.call(slot) ??
                                      BookingUtil.reformat(slot),
                                  style: getTextStyle(),
                                ),
                              ),
                            );
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                widget.bookingGridCrossAxisCount ?? 2,
                            childAspectRatio:
                                widget.bookingGridChildAspectRatio ?? 2.2,
                          ),
                        ),
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            BookingButton(
              buttonText: widget.bookingButtonText ?? 'Book now',
              isClicked: () async {
                controller.toggleUploading();
                await widget.uploadBooking(
                    newBooking: controller.createBookingModelToDB());
                controller.toggleUploading();
                controller.resetSelectedSlot();
              },
              isDisabled: controller.selectedSlot == -1,
              buttonActiveColor: widget.bookingButtonColor,
            ),
          ],
        ),
      ),
    );
  }
}
