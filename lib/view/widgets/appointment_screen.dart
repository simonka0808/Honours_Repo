import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:test_honours/main.dart';

import 'calendar_screen.dart';
import 'package:test_honours/core/booking_calendar.dart';
import 'package:test_honours/components/booking_calendar/booking_service.dart';
import 'package:test_honours/local_storage/our_doctors.dart';
import 'package:test_honours/model/enums.dart';

class AppointmentScreen extends StatelessWidget {
  final Doctor doctorInfo;
  final now = DateTime.now();
  final int currentDoctorIndex;

  AppointmentScreen(this.doctorInfo, {required this.currentDoctorIndex});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent.shade100,
      appBar: AppBar(
        title: Text("Doctor`s background"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: w,
                height: h / 3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      doctorInfo.imageUrl,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.blue.shade100.withOpacity(0.9),
                    Colors.blue.shade100.withOpacity(0),
                    Colors.blue.shade100.withOpacity(0),
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
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
                          "Patients",
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
                          doctorInfo.experience.toString(),
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
              SizedBox(height: 10),
              Padding(
                padding:
                    EdgeInsets.only(left: 30, top: 5, right: 30, bottom: 5),
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
                    SizedBox(height: 40),
                    GestureDetector(
                        // When the child is tapped, show a snackbar.
                        onTap: () {
                          Navigator.of(context).push(
                            new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BookingCalendarApp(
                                      activeIndex: currentDoctorIndex),
                            ),
                          );
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              'Book an Appointment',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
