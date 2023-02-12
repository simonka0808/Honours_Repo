import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_honours/widgets/bmi_result_page.dart';

class AppointmentDetails extends StatefulWidget {
  @override
  _AppointmentDetailsState createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController heightController = new TextEditingController();

  final currentUser = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: width,
              height: 70,
              color: Colors.lightBlue,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Give us some information about your case",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            // Padding(
            //   padding:
            //       EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 40),
            //   child: TextFormField(
            //     keyboardType: TextInputType.number,
            //     controller: descriptionController,
            //     decoration: InputDecoration(hintText: "Input your weight: "),
            //   ),
            // ),
            Container(
              padding: EdgeInsets.only(top: 35),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Description",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.blueAccent.shade400),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 40),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: heightController,
                decoration: InputDecoration(hintText: "What`s the problem? "),
              ), // optional
            ),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                child: const Text("Submit"),
                onPressed: () {
                  Map<String, dynamic> appointment_details = {
                    "description": descriptionController,
                  };
                  FirebaseFirestore.instance
                      .doc('client_bookings_doc')
                      .collection('client_bookings')
                      .add(appointment_details);
                },
                style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    textStyle: TextStyle(
                      fontSize: 20,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
