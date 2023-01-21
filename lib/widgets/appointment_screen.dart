import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_honours/model/doctors.dart';

class AppointmentScreen extends StatelessWidget {
  // final Doctor doctorInfo;
  //
  // AppointmentScreen(this.doctorInfo);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // children: [Image.network(doctorInfo.imageUrl)],
        ),
      ),
    );
  }
}
