import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/doctors.dart';

class AppointmentsList extends StatefulWidget {
  @override
  _AppointmentsListState createState() => _AppointmentsListState();
}

class _AppointmentsListState extends State<AppointmentsList> {
  final currentUser = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height * 0.2;
    return Scaffold(
        appBar: AppBar(
          title: Text("Upcoming appointments"),
        ),
        body: SafeArea(
            child: Column(
          children: [
            SizedBox(height: 20),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collectionGroup('client_bookings')
                    // .where('email', isEqualTo: currentUser.currentUser!.email)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          Doctor doctor = doctorsList[i];
                          var data = snapshot.data!.docs[i];
                          return SingleChildScrollView(
                            child: Container(
                              height: height,
                              width: width,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.blueGrey.shade100,
                                        blurRadius: 5,
                                        spreadRadius: 3)
                                  ]),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      InkWell(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15)),
                                          // child: Image.asset(
                                          //   doctor.imageUrl,
                                          //   height: 120,
                                          //   width: 200,
                                          //   fit: BoxFit.cover,
                                          // ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Column(children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Text(
                                            "Dr. " + data['doctorName'],
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blueAccent),
                                          )),
                                      Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text(
                                            doctor.type,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey),
                                          )),
                                      const Divider(
                                        height: 22,
                                        thickness: 0.4,
                                        // indent: 20,
                                        // endIndent: 0,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            data['bookingStart'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black87
                                                    .withOpacity(0.5)),
                                          )
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 100,
                                              height: 30,
                                              child: ElevatedButton(
                                                child: const Text("Cancel"),
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                    shape: StadiumBorder(),
                                                    textStyle: TextStyle(
                                                      fontSize: 15,
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    return Text("again error i am done");
                  }
                })
          ],
        )));
  }
}
