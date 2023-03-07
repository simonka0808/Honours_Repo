import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/welcome_page.dart';

class CancelApptBox extends StatelessWidget {
  const CancelApptBox({super.key});

  Future deleteAppt() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("client_bookings").get();

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];

      final collection =
          FirebaseFirestore.instance.collection('client_bookings');
      collection
          .doc(a.id) // <-- Doc ID to be deleted.
          .delete() // <-- Delete
          .then((_) => print('Deleted'))
          .catchError((error) => print('Delete failed: $error'));

      print(a.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure you want to cancel the appointment?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Yes');
            deleteAppt();
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
