import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/welcome_page.dart';

class MissingFieldsSnackBar extends StatelessWidget {
  const MissingFieldsSnackBar({super.key});

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: const Text('Oops! It seems you have not filled all fields!'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Try again');

          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
