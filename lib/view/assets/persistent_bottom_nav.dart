import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/appointments_list.dart';
import '../screens/bmi_input_page.dart';
import '../screens/location_screen.dart';
import '../screens/profile_page.dart';
import '../screens/welcome_page.dart';

class PersistentBottomNav extends StatefulWidget {
  const PersistentBottomNav({super.key});

  @override
  State<PersistentBottomNav> createState() => _PersistentBottomNavState();
}

class _PersistentBottomNavState extends State<PersistentBottomNav> {
  final currentUser = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          activeColor: Colors.black,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on_outlined), label: 'Location'),
            BottomNavigationBarItem(
                icon: Icon(Icons.medical_services_outlined),
                label: 'Appointments'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(
                      child: WelcomePage(
                          email: FirebaseAuth.instance.currentUser?.email ??
                              'default'));
                },
              );
            case 1:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: NearestHospitals());
                },
              );
            case 2:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(child: AppointmentsList());
                },
              );
            case 3:
              return CupertinoTabView(
                builder: (context) {
                  return CupertinoPageScaffold(
                      child: ProfilePage(
                          email: FirebaseAuth.instance.currentUser?.email ??
                              'default'));
                },
              );
          }
          return Container();
        });
    throw UnimplementedError();
  }
}
