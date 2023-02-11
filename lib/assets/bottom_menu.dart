import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:test_honours/db/auth_controller.dart';
import 'package:test_honours/screens/profile_page.dart';
import 'package:test_honours/screens/welcome_page.dart';
import 'package:test_honours/screens/bmi_input_page.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';

import 'package:test_honours/screens/welcome_page.dart';
import 'package:test_honours/screens/bmi_input_page.dart';
import 'package:test_honours/screens/profile_page.dart';

class MyNavigationBar extends StatefulWidget {
  String email;
  MyNavigationBar({Key? key, required this.email}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;

  final currentUser = FirebaseAuth.instance;

  final List<Widget> _widgetOptions = <Widget>[
    WelcomePage(email: FirebaseAuth.instance.currentUser?.email ?? 'default'),
    BMICalculator(),
    BMICalculator(),
    ProfilePage(email: FirebaseAuth.instance.currentUser?.email ?? 'default')
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: CustomNavigationBar(
        isFloating: true,
        elevation: 2,
        iconSize: 30,
        selectedColor: Colors.blueAccent,
        items: [
          CustomNavigationBarItem(
              icon: Icon(Icons.home_outlined)), //welcome page
          CustomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined)), //gps location page
          CustomNavigationBarItem(
              icon: Icon(Icons
                  .medical_services_outlined)), //bmi calculator or future appointments
          CustomNavigationBarItem(icon: Icon(Icons.settings))
        ],
        onTap: (i) {
          setState(() {
            _selectedIndex = i;
          });
        },
        currentIndex: _selectedIndex,
      ),
    ));
  }
}
