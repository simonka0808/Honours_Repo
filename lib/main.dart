import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:test_honours/components/appointment/single_user_booked_provider.dart';
import 'package:test_honours/controller/auth/auth_controller.dart';
import 'package:test_honours/view/screens/login_page.dart';
import 'dart:core';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserBooksProvider()),
      ],
      child: GetMaterialApp(
          title: 'Honours Project',
          theme: ThemeData(primarySwatch: Colors.blue,),
          home: new LoginPage()),
    );
  }
}

