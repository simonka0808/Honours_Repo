import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_honours/assets/cancel_appt_box.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../model/doctors.dart';

class AppointmentsList extends StatefulWidget {
  @override
  _AppointmentsListState createState() => _AppointmentsListState();
}

class _AppointmentsListState extends State<AppointmentsList> {
  final currentUser = FirebaseAuth.instance;

  static Future<void> opentApptMap() async {
    for (var i = 0; i < doctorsList.length; i++) {
      Doctor doctor = doctorsList[i];

      double latitude = doctor.apptLat;
      double longitude = doctor.apptLng;

      String googleUrl =
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
      if (await canLaunch(googleUrl) != null) {
        await launch(googleUrl);
      } else {
        throw 'Could not open the map.';
      }
    }

    // double latitude = 57.152944651282304;
    // double longitude = -2.102075401560233;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height * 0.27;

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  child: Text("Upcoming"),
                ),
                Tab(
                  child: Text("Past"),
                )
              ],
            ),
            title: const Text('Your appointments'),
          ),
          body: TabBarView(
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('client_bookings')
                            .where("email",
                            isEqualTo: FirebaseAuth.instance.currentUser?.email)
                            .snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Text("You do not have any upcoming appointments", style: TextStyle(fontWeight: FontWeight.bold));
                          } else if (snapshot.hasData) {
                            return ListView.builder(
                                itemCount: snapshot.data?.docs.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, int i) {
                                  var data = snapshot.data!.docs[i];

                                  return Container(
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
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Column(children: [
                                          Padding(
                                              padding:
                                              EdgeInsets.only(left: 15, top: 8),
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
                                                data['doctorType'],
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 15, color: Colors.grey),
                                              )),
                                          const Divider(
                                            height: 22,
                                            thickness: 0.4,
                                            color: Colors.grey,
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.access_time_outlined),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    data['bookingStart'],
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black87
                                                            .withOpacity(0.5)),
                                                  )),
                                              Icon(Icons.location_on_outlined),
                                              Expanded(
                                                flex: 1,
                                                child: TextButton(
                                                    onPressed: () {
                                                      opentApptMap();
                                                    },
                                                    child: Text(
                                                      data['hospitalName'],
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          decoration: TextDecoration
                                                              .underline),
                                                    )),
                                              )
                                            ],
                                          ),
                                          Padding(
                                              padding:
                                              const EdgeInsets.only(top: 5.0),
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: SizedBox(
                                                      // width: 80,
                                                      height: 30,
                                                      child: ElevatedButton(
                                                        child: const Text("Cancel"),
                                                        onPressed: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      CancelApptBox()));
                                                        },
                                                        style:
                                                        ElevatedButton.styleFrom(
                                                            shape:
                                                            StadiumBorder(),
                                                            textStyle: TextStyle(
                                                              fontSize: 15,
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding:
                                                      EdgeInsets.only(right: 8)),
                                                  Expanded(
                                                    child: SizedBox(
                                                      // width: 80,
                                                      height: 30,
                                                      child: ElevatedButton(
                                                        child:
                                                        const Text("Reschedule"),
                                                        onPressed: () {},
                                                        style:
                                                        ElevatedButton.styleFrom(
                                                            shape:
                                                            StadiumBorder(),
                                                            textStyle: TextStyle(
                                                              fontSize: 15,
                                                            )),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ))
                                        ])),
                                  );
                                });
                          } else {
                            print("no data");
                            return Container(
                              child: Text("no", style: TextStyle(fontWeight: FontWeight.bold)),
                            );
                          }
                        })
                  ]),
              Icon(Icons.directions_transit)
            ],
          ),
        ),
      ),
    );
  }
}


//
//
// return Scaffold(
//     appBar: AppBar(
//       title: Text("Upcoming appointments"),
//     ),
//     body: Center(
//         child: SingleChildScrollView(
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//           SizedBox(height: 20),
//           StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('client_bookings')
//                   .where("email",
//                       isEqualTo: FirebaseAuth.instance.currentUser?.email)
//                   .snapshots(),
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (!snapshot.hasData) {
//                   return Text("You do not have any upcoming appointments", style: TextStyle(fontWeight: FontWeight.bold));
//                 } else if (snapshot.hasData) {
//                   return ListView.builder(
//                       itemCount: snapshot.data?.docs.length,
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       itemBuilder: (context, int i) {
//                         var data = snapshot.data!.docs[i];
//
//                         return Container(
//                           height: height,
//                           width: width,
//                           margin: EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 10),
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(20),
//                               boxShadow: [
//                                 BoxShadow(
//                                     color: Colors.blueGrey.shade100,
//                                     blurRadius: 5,
//                                     spreadRadius: 3)
//                               ]),
//                           child: Align(
//                               alignment: Alignment.center,
//                               child: Column(children: [
//                                 Padding(
//                                     padding:
//                                         EdgeInsets.only(left: 15, top: 8),
//                                     child: Text(
//                                       "Dr. " + data['doctorName'],
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                           fontSize: 17,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.blueAccent),
//                                     )),
//                                 Padding(
//                                     padding: EdgeInsets.only(top: 5),
//                                     child: Text(
//                                       data['doctorType'],
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                           fontSize: 15, color: Colors.grey),
//                                     )),
//                                 const Divider(
//                                   height: 22,
//                                   thickness: 0.4,
//                                   color: Colors.grey,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Icon(Icons.access_time_outlined),
//                                     Expanded(
//                                         flex: 1,
//                                         child: Text(
//                                           data['bookingStart'],
//                                           style: TextStyle(
//                                               fontSize: 16,
//                                               color: Colors.black87
//                                                   .withOpacity(0.5)),
//                                         )),
//                                     Icon(Icons.location_on_outlined),
//                                     Expanded(
//                                       flex: 1,
//                                       child: TextButton(
//                                           onPressed: () {
//                                             opentApptMap();
//                                           },
//                                           child: Text(
//                                             data['hospitalName'],
//                                             textAlign: TextAlign.center,
//                                             style: TextStyle(
//                                                 decoration: TextDecoration
//                                                     .underline),
//                                           )),
//                                     )
//                                   ],
//                                 ),
//                                 Padding(
//                                     padding:
//                                         const EdgeInsets.only(top: 5.0),
//                                     child: Row(
//                                       children: <Widget>[
//                                         Expanded(
//                                           child: SizedBox(
//                                             // width: 80,
//                                             height: 30,
//                                             child: ElevatedButton(
//                                               child: const Text("Cancel"),
//                                               onPressed: () {
//                                                 Navigator.of(context).push(
//                                                     MaterialPageRoute(
//                                                         builder: (context) =>
//                                                             CancelApptBox()));
//                                               },
//                                               style:
//                                                   ElevatedButton.styleFrom(
//                                                       shape:
//                                                           StadiumBorder(),
//                                                       textStyle: TextStyle(
//                                                         fontSize: 15,
//                                                       )),
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                             padding:
//                                                 EdgeInsets.only(right: 8)),
//                                         Expanded(
//                                           child: SizedBox(
//                                             // width: 80,
//                                             height: 30,
//                                             child: ElevatedButton(
//                                               child:
//                                                   const Text("Reschedule"),
//                                               onPressed: () {},
//                                               style:
//                                                   ElevatedButton.styleFrom(
//                                                       shape:
//                                                           StadiumBorder(),
//                                                       textStyle: TextStyle(
//                                                         fontSize: 15,
//                                                       )),
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ))
//                               ])),
//                         );
//                       });
//                 } else {
//                   print("no data");
//                   return Container(
//                     child: Text("no", style: TextStyle(fontWeight: FontWeight.bold)),
//                   );
//                 }
//               })
//         ]))));
