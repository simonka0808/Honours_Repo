import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppointmentsList extends StatefulWidget {
  @override
  _AppointmentsListState createState() => _AppointmentsListState();
}

class _AppointmentsListState extends State<AppointmentsList> {
  String bookingStart = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your upcoming appointments"),
        ),
        body: Center(
          child: FutureBuilder(
            future: _fetchBookingDataFromFirebase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done)
                return Text("Loading data....");
              return Text("Booking start: $bookingStart");
            },
          ),
        ));
    // TODO: implement build
    throw UnimplementedError();
  }

  _fetchBookingDataFromFirebase() async {
    final loggedInUser = await FirebaseAuth.instance.currentUser;
    if (loggedInUser != null) {
      await FirebaseFirestore.instance
          .collection('client_bookings_doc')
          .doc(loggedInUser.email)
          .get()
          .then((snapshot) {
        bookingStart = snapshot.data()!['email'];
        print(bookingStart);
      }).catchError((e) {
        print(e);
      });
    }
  }
}
