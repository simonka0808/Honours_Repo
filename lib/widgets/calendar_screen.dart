import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_honours/model/doctors.dart';

import '../core/booking_calendar.dart';
import '../components/booking_calendar/booking_service.dart';
import '../model/enums.dart';

class BookingCalendarDemoApp extends StatefulWidget {
  final int? currentIndex;
  const BookingCalendarDemoApp({Key? key, this.currentIndex}) : super(key: key);

  @override
  State<BookingCalendarDemoApp> createState() => _BookingCalendarDemoAppState();
}

class _BookingCalendarDemoAppState extends State<BookingCalendarDemoApp> {
  final currentUser = FirebaseAuth.instance;

  final now = DateTime.now();
  late BookingModel bookingCalendarModel;
  late List<DateTimeRange> breakHoursList = [];
  List<DateTimeRange> converted = [];
  List<BookingModel> bookingList = [];
  final ScrollController controller = ScrollController();
  CollectionReference bookings =
      FirebaseFirestore.instance.collection('client_bookings');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final w = MediaQuery.of(context).size.width;
      controller.jumpTo(w * (widget.currentIndex ?? 0));
    });
  }

  CollectionReference<BookingModel> getBookingStream(
      {required String placeId}) {
    return bookings
        .doc(placeId)
        .collection('client_bookings')
        .withConverter<BookingModel>(
          fromFirestore: (snapshots, _) =>
              BookingModel.fromJson(snapshots.data()!),
          toFirestore: (snapshots, _) => snapshots.toJson(),
        );
  }

  Future<dynamic> uploadBookingFirebase(
      {required BookingModel newBooking}) async {
    await bookings
        .doc('client_bookings_doc')
        .collection('client_bookings')
        .add(newBooking.toJson())
        .then((value) => print("Successfully added"))
        .catchError((error) => print("Error: $error"));
  }

  List<DateTimeRange> generatePauseSlots() {
    for (var i = 0; i < doctorsList.length; i++) {
      Doctor doctor = doctorsList[i];
      breakHoursList.add(DateTimeRange(
          start: doctor.startBreakHour, end: doctor.endBreakHour));
    }
    return breakHoursList;
  }

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return Stream.value([]);
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
            controller: controller,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: bookingList.length,
            itemBuilder: (context, index) {
              return Container(
                width: w,
                height: h,
                color: index.isEven ? Colors.deepPurple : Colors.cyanAccent,
                child: Column(
                  children: [
                    Expanded(
                        child: BookingCalendar(
                      bookingService: bookingList.elementAt(index),
                      getBookingStream: getBookingStreamMock,
                      uploadBooking: uploadBookingFirebase,
                      pauseSlots: generatePauseSlots(),
                      hideBreakTime: false,
                      loadingWidget: const Text('Fetching data...'),
                      uploadingWidget: const CircularProgressIndicator(),
                      locale: 'en_US',
                      startingDayOfWeek: CalendarDays.monday,
                      wholeDayIsBookedWidget:
                          const Text('Fully booked! Choose another day'),
                    ))
                  ],
                ),
              );
            }),
      ),
    );
  }
}
