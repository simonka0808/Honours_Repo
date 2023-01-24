import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../model/doctors.dart';
import 'booking_calendar.dart';

class AppointmentScreen extends StatelessWidget {
  final Doctor doctorInfo;

  AppointmentScreen(this.doctorInfo);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.width;

    return Material(
      color: Colors.lightBlueAccent.shade100,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: w,
              height: h / 2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    doctorInfo.imageUrl,
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.blue.shade100.withOpacity(0.9),
                  Colors.blue.shade100.withOpacity(0),
                  Colors.blue.shade100.withOpacity(0),
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 30, left: 20, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.all(8),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
            ),
            SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Patients" + doctorInfo.startHour.toString(),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "1.7k",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Rating",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 8),
                      Text(
                        doctorInfo.star,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Experience",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "15 yr",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctorInfo.name,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(MdiIcons.heartPlus, color: Colors.red, size: 25),
                      SizedBox(width: 5),
                      Text(
                        doctorInfo.type,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45.withOpacity(0.6),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 25),
                  Text(
                    doctorInfo.info,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black45.withOpacity(0.6),
                    ),
                  ),
                  SizedBox(height: 30),
                  SfCalendar(
                    view: CalendarView.workWeek,
                    specialRegions: lunchTime(),
                    timeSlotViewSettings: TimeSlotViewSettings(
                        timeTextStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                        startHour: doctorInfo.startHour,
                        endHour: doctorInfo.endHour,
                        numberOfDaysInView: 4,
                        timeIntervalHeight: 50,
                        timeIntervalWidth: 50,
                        nonWorkingDays: <int>[
                          DateTime.friday,
                          DateTime.saturday
                        ]),
                  ),
                  // GestureDetector(
                  //   // When the child is tapped, show a snackbar.
                  //   onTap: () {
                  //     Navigator.of(context).push(new MaterialPageRoute(
                  //         builder: (BuildContext context) =>
                  //             new GoogleSheetData())); //your login class name
                  //   },
                  //   // The custom button
                  //   child: Container(
                  //     padding: const EdgeInsets.all(12.0),
                  //     decoration: BoxDecoration(
                  //       color: Colors.lightBlue,
                  //       borderRadius: BorderRadius.circular(8.0),
                  //     ),
                  //     child: const Text('Book an Appointment'),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<TimeRegion> lunchTime() {
  final List<TimeRegion> lunchTimeSession = <TimeRegion>[];
  lunchTimeSession.add(TimeRegion(
      startTime: DateTime(2023, 1, 24, 13, 0, 0),
      endTime: DateTime(2023, 1, 24, 14, 0, 0),
      recurrenceRule: 'FREQ=WEEKLY;INTERVAL=1;BYDAY=MON,TUE,WED,THU,FRI',
      text: "Break",
      color: Colors.amber,
      enablePointerInteraction: true,
      textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)));

  return lunchTimeSession;
}
