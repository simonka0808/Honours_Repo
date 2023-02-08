import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_honours/model/doctors.dart';

import '../core/booking_calendar.dart';
import '../model/booking_service.dart';
import '../model/enums.dart';

import '../model/doctors.dart';

class BookingCalendarDemoApp extends StatefulWidget {
  final List<BookingModel> bookingList;
  const BookingCalendarDemoApp({
    Key? key,
    required this.bookingList,
  }) : super(key: key);

  @override
  State<BookingCalendarDemoApp> createState() => _BookingCalendarDemoAppState();
}

class _BookingCalendarDemoAppState extends State<BookingCalendarDemoApp> {
  final now = DateTime.now();
  late BookingModel bookingCalendarModel;
  late List<BookingModel> bookingList = widget.bookingList;
  List<DateTimeRange> converted = [];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < doctorsList.length; i++) {
      Doctor doctor = doctorsList[i];
      bookingList.add(bookingCalendarModel = new BookingModel(
          apptName: 'Mock Service',
          apptDuration: doctor.duration,
          bookingEnd: doctor.endHour,
          bookingStart: doctor.startHour));
    }
  }

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }

  Future<dynamic> uploadBookingMock({required BookingModel newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));
    converted.add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));
    print('${newBooking.toJson()} has been uploaded');
  }

  // /After you fetched the data from firestore, we only need to have a list of datetimes from the bookings:
  List<DateTimeRange> convertStreamResultFirebase(
      {required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    ///Note that this is dynamic, so you need to know what properties are available on your result, in our case the [SportBooking] has bookingStart and bookingEnd property
    List<DateTimeRange> converted = [];
    for (var i = 0; i < streamResult.size; i++) {
      final item = streamResult.docs[i].data();
      converted.add(
          DateTimeRange(start: (item.bookingStart!), end: (item.bookingEnd!)));
    }
    return converted;
  }

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    ///take care this is only mock, so if you add today as disabledDays it will still be visible on the first load
    ///disabledDays will properly work with real data
    DateTime first = now;
    DateTime tomorrow = now.add(Duration(days: 1));
    DateTime second = now.add(const Duration(minutes: 55));
    DateTime third = now.subtract(const Duration(minutes: 240));
    DateTime fourth = now.subtract(const Duration(minutes: 500));
    converted.add(
        DateTimeRange(start: first, end: now.add(const Duration(minutes: 30))));
    converted.add(DateTimeRange(
        start: second, end: second.add(const Duration(minutes: 23))));
    converted.add(DateTimeRange(
        start: third, end: third.add(const Duration(minutes: 15))));
    converted.add(DateTimeRange(
        start: fourth, end: fourth.add(const Duration(minutes: 50))));

    //book whole day example
    converted.add(DateTimeRange(
        start: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 5, 0),
        end: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 23, 0)));
    return converted;
  }

  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(
          start: DateTime(now.year, now.month, now.day, 12, 0),
          end: DateTime(now.year, now.month, now.day, 14, 0))
    ];
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: h,
        width: w,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: bookingList.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: w,
                height: h,
                child: Column(
                  children: [
                    Expanded(
                      child: new BookingCalendar(
                          bookingService: bookingList[index],
                          convertStreamResultToDateTimeRanges:
                              convertStreamResultMock,
                          getBookingStream: getBookingStreamMock,
                          uploadBooking: uploadBookingMock,
                          pauseSlots: generatePauseSlots(),
                          hideBreakTime: false,
                          loadingWidget: const Text('Fetching data...'),
                          uploadingWidget: const CircularProgressIndicator(),
                          locale: 'en_US',
                          startingDayOfWeek: CalendarDays.monday,
                          wholeDayIsBookedWidget:
                              const Text('Fully booked! Choose another day'),
                          disabledDates: [DateTime(2023, 1, 20)],
                          disabledDays: [6, 7]),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
