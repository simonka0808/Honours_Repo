// import 'dart:core';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
// import 'package:test_honours/model/doctors.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';
// import 'dart:convert' as convert;
//
// import 'package:http/http.dart' as http;
//
// import '../model/doctors.dart';
//
// class GoogleSheetData extends StatelessWidget {
//   final Doctor doctor;
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.white,
//       child: SfCalendar(
//         view: CalendarView.workWeek,
//         specialRegions: lunchTime(),
//         timeSlotViewSettings: TimeSlotViewSettings(
//             timeTextStyle: TextStyle(
//               fontWeight: FontWeight.w500,
//               fontStyle: FontStyle.italic,
//               fontSize: 15,
//               color: Colors.blue,
//             ),
//             startHour: doctor.startHour,
//             endHour: doctor.endHour,
//             numberOfDaysInView: 4,
//             timeIntervalHeight: 50,
//             timeIntervalWidth: 50,
//             nonWorkingDays: <int>[DateTime.friday, DateTime.saturday]),
//       ),
//     );
//   }
// }
//
// List<TimeRegion> lunchTime() {
//   final List<TimeRegion> lunchTimeSession = <TimeRegion>[];
//   lunchTimeSession.add(TimeRegion(
//       startTime: DateTime(2023, 1, 24, 13, 0, 0),
//       endTime: DateTime(2023, 1, 24, 14, 0, 0),
//       recurrenceRule: 'FREQ=WEEKLY;INTERVAL=1;BYDAY=MON,TUE,WED,THU,FRI',
//       text: "Break",
//       color: Colors.amber,
//       enablePointerInteraction: true,
//       textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)));
//
//   return lunchTimeSession;
// }
