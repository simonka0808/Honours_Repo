import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/welcome_page.dart';

class BookingConfirmation extends StatelessWidget {
  const BookingConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance;

    return AlertDialog(
      title: const Text('Thank you for booking!'),
      content: const Text('Please check you Appointment Page'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'OK');

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => WelcomePage(
                      email: currentUser.currentUser!.email.toString(),
                    )));
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
