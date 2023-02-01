import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_honours/db/auth_controller.dart';

class ProfilePage extends StatelessWidget {
  String email;
  ProfilePage({Key? key, required this.email}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          SizedBox(height: 50),
          Container(
            height: 220,
            width: 220,
            decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(110)),
          ),
          SizedBox(height: 10),
          Text(
            email,
            style: TextStyle(
                color: Colors.black45,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 40),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 220,
                  height: 50,
                  child: ElevatedButton(
                    child: const Text("Privacy"),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        shape: StadiumBorder(),
                        textStyle: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: 220,
                  height: 50,
                  child: ElevatedButton(
                    child: const Text("Support"),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        shape: StadiumBorder(),
                        textStyle: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: 220,
                  height: 50,
                  child: ElevatedButton(
                    child: const Text("Logout"),
                    onPressed: () {
                      AuthController.instance.logOut();
                    },
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        shape: StadiumBorder(),
                        textStyle: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: 220,
                  height: 50,
                  child: ElevatedButton(
                    child: const Text("Delete Account"),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        shape: StadiumBorder(),
                        textStyle: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}
