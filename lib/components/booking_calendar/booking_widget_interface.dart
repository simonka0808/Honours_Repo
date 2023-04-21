import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:table_calendar/table_calendar.dart' as tc
    show StartingDayOfWeek;
import 'package:test_honours/components/appointment/appointment_details.dart';

import '../../controller/booking/booking_controller.dart';
import '../appointment/single_user_booked_provider.dart';
import 'booking_service.dart';
import '../../model/enums.dart' as bc;
import '../../utilites//booking_util.dart';
import '../booking_calendar/single_booking_slot.dart';
import '../booking_calendar/booking_button.dart';
import '../booking_calendar/booking_scheme.dart';
import '../booking_calendar/booking_legend.dart';

class BookingCalendarInterface extends StatefulWidget {
  const BookingCalendarInterface({
    Key? key,
    required this.getBookingStream,
    required this.uploadBooking,
    this.bookingExplanation,
    this.numberOfRows,
    this.formatTimeSlotDate,
    this.buttonColor,
    this.ifErrorOccursWidget,
    this.wholeDayIsBookedWidget,
    this.breakSlotColor,
    this.breakText,
    this.timeZoneFormat,
    this.firstWorkingDay,
    this.bookedSlotColor,
    this.clickedSlotColor,
    this.availableSlotColor,
    this.bookedSlotText,
    this.bookedSlotTextStyle,
    this.clickedText,
    this.selectedSlotTextStyle,
    this.freeText,
    this.availableSlotTextStyle,
  }) : super(key: key);

  final Stream<dynamic>? Function(
      {required DateTime start, required DateTime end}) getBookingStream;
  final Future<dynamic> Function({required BookingModel newBooking})
      uploadBooking;

  final Widget? bookingExplanation;
  final int? numberOfRows;
  final String Function(DateTime dt)? formatTimeSlotDate;
  final Color? buttonColor;

  final Color? bookedSlotColor;
  final Color? clickedSlotColor;
  final Color? availableSlotColor;
  final Color? breakSlotColor;

  final Widget? ifErrorOccursWidget;

  final String? timeZoneFormat;
  final bc.CalendarDays? firstWorkingDay;

  final Widget? wholeDayIsBookedWidget;

  final String? bookedSlotText;
  final String? clickedText;
  final String? freeText;
  final String? breakText;

  final TextStyle? bookedSlotTextStyle;
  final TextStyle? availableSlotTextStyle;
  final TextStyle? selectedSlotTextStyle;

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

    final firstDay = DateTime.now();

    startTime = firstDay.startOfDayAppt(controller.apptStart!);
    endTime = firstDay.endOfDayAppt(controller.apptEnd!);


    _focusedDay = firstDay;
    _selectedDay = firstDay;
  }

  CalendarFormat calendar = CalendarFormat.twoWeeks;

  late DateTime _selectedDay;
  late DateTime _focusedDay;
  late DateTime startTime;
  late DateTime endTime;

  void calculateTimeRange() {
    startTime = _selectedDay.startOfDayAppt(controller.apptStart!);
    endTime = _selectedDay
        .add(const Duration(days: 1))
        .endOfDayAppt(controller.apptEnd!);

    controller.base = startTime;
    controller.resetSelectedSlot();
  }

  late Stream<dynamic>? stream =
      widget.getBookingStream(start: startTime, end: endTime);

  //temporary hold for single user book on
  TempModel? tempModel;
  @override
  Widget build(BuildContext context) {
    // controller = context.watch<BookingController>();

    return Consumer<BookingController>(
      builder: (_, controller, __) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
            BookingSlot(
              timeSlot: TableCalendar(
                startingDayOfWeek: widget.firstWorkingDay?.toTC() ??
                    tc.StartingDayOfWeek.monday,
                locale: widget.timeZoneFormat,
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(const Duration(days: 80)),
                focusedDay: _focusedDay,
                calendarFormat: calendar,
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
                    calculateTimeRange();
                  }
                },
                onFormatChanged: (format) {
                  if (calendar != format) {
                    setState(() {
                      calendar = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
            ),
            const SizedBox(height: 5),
            widget.bookingExplanation ??
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 9.0,
                  runSpacing: 2.0,
                  direction: Axis.horizontal,
                  children: [
                    BookingLegend(
                        legendIconColor: Colors.greenAccent,
                        legendText: "Available"),
                    BookingLegend(
                        legendIconColor: Colors.lightBlueAccent,
                        legendText: "Selected"),
                    BookingLegend(
                        legendIconColor: Colors.redAccent,
                        legendText: "Booked"),
                    BookingLegend(
                        legendIconColor: Colors.grey, legendText: "Break"),
                  ],
                ),
            const SizedBox(height: 3),
            StreamBuilder<dynamic>(
              stream: stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return widget.ifErrorOccursWidget ??
                      Center(
                        child: Text(snapshot.error.toString()),
                      );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                debugPrint(snapshot.data.toString());
                return Expanded(
                  child: (widget.wholeDayIsBookedWidget != null &&
                          controller.isFullyBooked())
                      ? widget.wholeDayIsBookedWidget!
                      : Consumer<UserBooksProvider>(
                          builder: (context, userBookProvider, child) =>
                              GridView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: controller.allSlotsForBooking.length,
                            itemBuilder: (context, index) {
                              bool isChecked = userBookProvider.isBooked(
                                      controller, index) || //todo
                                  controller.checkIfBooked(index);
                              TextStyle? getTextStyle() {
                                if (isChecked) {
                                  return widget.bookedSlotTextStyle;
                                } else if (index == controller.selectedSlot) {
                                  return widget.selectedSlotTextStyle;
                                } else {
                                  return widget.availableSlotTextStyle;
                                }
                              }

                              final slot = controller.allSlotsForBooking
                                  .elementAt(index);

                              return BookingSchemeAvailability(
                                isBreakTime: controller.isBreakTime(slot),
                                isBooked: isChecked,
                                isSelected: index == controller.selectedSlot,
                                isClicked: () {
                                  controller.selectSlot(index);
                                  tempModel = TempModel(
                                      controller.bookingModel.doctorName, slot);
                                },
                                breakSlotColor: widget.breakSlotColor,
                                availableSlotColor: widget.availableSlotColor,
                                bookedSlotColor: widget.bookedSlotColor,
                                selectedSlotColor: widget.clickedSlotColor,
                                timeSlot: Center(
                                  child: Text(
                                    widget.formatTimeSlotDate?.call(slot) ??
                                        BookingUtil.reformat(slot),
                                    style: getTextStyle(),
                                  ),
                                ),
                              );
                            },
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: widget.numberOfRows ?? 2,
                              childAspectRatio: 2.3,
                            ),
                          ),
                        ),
                );
              },
            ),
            const SizedBox(
              height: 14,
            ),
            BookingButton(
              buttonText: 'Book now',
              isClicked: () async {
                controller.toggleUploading();
                await widget.uploadBooking(
                    newBooking: controller.createBookingModelToDB());
                controller.toggleUploading();
                controller.resetSelectedSlot();
                final result = await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            AppointmentDetails()));

                /// means we will get data back from the next page while it is successfully booked the schedule
                if (result == true && tempModel != null) {
                  context.read<UserBooksProvider>().addBooking(tempModel!);
                  // stream =
                  //     widget.getBookingStream(start: startTime, end: endTime);
                  // setState(() {});
                }
              },
              isDisabled: controller.selectedSlot == -1,
              buttonActiveColor: widget.buttonColor,
            ),
          ],
        ),
      ),
    );
  }
}
