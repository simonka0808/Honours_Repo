import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppointmentsList extends StatefulWidget {
  @override
  _AppointmentsListState createState() => _AppointmentsListState();
}

class _AppointmentsListState extends State<AppointmentsList> {
  final currentUser = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your upcoming appointments"),
        ),
        body: SafeArea(
            child: Column(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('client_bookings')
                    .where('email', isEqualTo: currentUser.currentUser!.email)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          var data = snapshot.data!.docs[i];
                          Text(data['doctorName']);
                        });
                  } else {
                    return Text("error");
                  }
                })
          ],
        )));
  }
}
