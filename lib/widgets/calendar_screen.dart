import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:test_honours/model/doctors.dart';
import 'package:test_honours/util/booking_business_logic.dart';

import '../core/booking_calendar.dart';
import '../components/booking_calendar/booking_service.dart';
import '../model/enums.dart';

class BookingCalendarDemoApp extends StatefulWidget {
  final int activeIndex;
  const BookingCalendarDemoApp({Key? key, required this.activeIndex})
      : super(key: key);

  @override
  State<BookingCalendarDemoApp> createState() => _BookingCalendarDemoAppState();
}

class _BookingCalendarDemoAppState extends State<BookingCalendarDemoApp> {
  final currentUser = FirebaseAuth.instance;

  final now = DateTime.now();

  late List<DateTimeRange> breakHoursList = [];
  List<DateTimeRange> converted = [];
  List<BookingModel> bookingList = [];

  CollectionReference bookings =
      FirebaseFirestore.instance.collection('client_bookings');

  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < doctorsList.length; i++) {
      Doctor doctor = doctorsList[i];
      final bookingCalendarModel = BookingModel(
          doctorName: doctor.name,
          apptName: 'test appt name',
          apptDuration: doctor.duration,
          apptEnd: doctor.endHour,
          description: 'test description',
          email: FirebaseAuth.instance.currentUser?.email ?? 'user',
          apptStart: doctor.startHour);
      bookingList.add(bookingCalendarModel);
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final w = MediaQuery.of(context).size.width;
      controller.jumpTo(w * (widget.activeIndex));
    });
  }

  Stream<dynamic>? getBookingStreamFirebase(
      {required DateTime end, required DateTime start}) {
    return BusinessLogic()
        .getBookingStream(placeId: 'YOUR_DOC_ID')
        .where('bookingStart', isGreaterThanOrEqualTo: start)
        .where('bookingStart', isLessThanOrEqualTo: end)
        .snapshots();
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (_, constraints) {
            final h = constraints.maxHeight;
            final w = constraints.maxWidth;
            return Container(
              height: h,
              width: w,
              color: Colors.deepPurple,
              child: bookingList.isEmpty
                  ? Center(child: Text("Got empty List"))
                  : ListView.builder(
                      shrinkWrap: true,
                      controller: controller,
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: bookingList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: w,
                          height: h,
                          color: index.isEven
                              ? Colors.deepPurple
                              : Colors.cyanAccent,
                          child: Column(
                            children: [
                              SizedBox(
                                height: h,
                                width: w,
                                child: BookingCalendar(
                                  bookingService: bookingList.elementAt(index),
                                  getBookingStream: getBookingStreamFirebase,
                                  uploadBooking: uploadBookingFirebase,
                                  pauseSlots: generatePauseSlots(),
                                  hideBreakTime: false,
                                  loadingWidget: const Text('Fetching data...'),
                                  uploadingWidget:
                                      const CircularProgressIndicator(),
                                  locale: 'en_US',
                                  startingDayOfWeek: CalendarDays.monday,
                                  wholeDayIsBookedWidget: const Text(
                                      'Fully booked! Choose another day'),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
            );
          },
        ),
      ),
    );
  }
}
