import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:test_honours/model/DoctorsGoogleSheet.dart';

class CategorySkeleton extends StatefulWidget {
  // final String name,
  //     type,
  //     patients,
  //     info,
  //     startHour,
  //     endHour,
  //     experience,
  //     apptLng,
  //     apptLat;
  //
  // CategorySkeleton(
  //     {required this.name,
  //     required this.type,
  //     required this.apptLat,
  //     required this.apptLng,
  //     required this.experience,
  //     required this.endHour,
  //     required this.startHour,
  //     required this.info,
  //     required this.patients});

  @override
  _CategorySkeletonState createState() => _CategorySkeletonState();
}

class _CategorySkeletonState extends State<CategorySkeleton> {
  List<DoctorsGoogleSheet> doctors = <DoctorsGoogleSheet>[];
  getDoctorsFromGoogleSheet() async {
    var url = Uri.parse(
        "https://script.googleusercontent.com/macros/echo?user_content_key=_69zPekvq-Jls9l62gZiby2w7wG3Bp9H8mWJpEVBFZXHeHIMyy3qKK34ZVBGk7Vr01sshbJrUTQakjjGm29QaBHrvEl9VFJxm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnGR2OjDluDS8WNy2jfGH1i8PUbpRFRcLZ4N4V2t-OFHqxY_GKqXyNl6fnpKytLEDytEkHd4BSfXfDFWTrgYeUsChw9oWEFzd5dz9Jw9Md8uu&lib=MJ5OfjhjaF0waUzUrYk_PD90r5WCT0duK");
    var raw = await http.get(url);
    List<dynamic> jsonDoctors = convert.jsonDecode(raw.body);

    // var jsonDoctors = convert.jsonDecode(raw.b
    // doctors = jsonDoctors.map((json) => DoctorsGoogleSheet.fromJson(json));
    print('this is json feedback $jsonDoctors');

    jsonDoctors.forEach((element) {
      print('$element THIS IS NEXT=>>>>>>>');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getDoctorsFromGoogleSheet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.cyan,
        appBar: AppBar(
          title: Text(""),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [],
            ),
          ),
        ));
  }
}
