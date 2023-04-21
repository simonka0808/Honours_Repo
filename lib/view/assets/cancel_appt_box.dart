import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/welcome_page.dart';

class CancelApptBox extends StatelessWidget {
  late String id;
  CancelApptBox(String id, {super.key});

   deleteAppt(id) async {

    await FirebaseFirestore.instance.collection('client_bookings').doc(id).delete();
    }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure you want to cancel the appointment?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Yes');
            deleteAppt(id);
          },
          child: const Text('Yes',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'Go back'),
          child: const Text('Go back'),
        ),
      ],
    );
  }
}
