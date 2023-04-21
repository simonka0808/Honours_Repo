// import 'package:flutter/material.dart';
// import 'package:test_honours/components/maps/search_places.dart';
//
// class LocationScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var w = MediaQuery.of(context).size.width;
//     var h = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: Colors.lightBlueAccent.shade100,
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Icon(Icons.local_hospital_outlined),
//             SizedBox(height: 8),
//             Text( "Find the nearest hospitals"),
//           ],
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(padding: EdgeInsets.only(left: 50, right: 30, top: 30)),
//               Center(
//                   child: Text(
//                 "In case of emergency situation please use the button below!",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                 ),
//               )),
//               SizedBox(height: 50),
//               ElevatedButton(
//                 child: const Text("Near by Hospitals"),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           NearestHospitals(), //TODO:
//                     ),
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//                     shape: StadiumBorder(),
//                     textStyle: TextStyle(
//                       fontSize: 20,
//                       color: Colors.white
//                     )),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:test_honours/controller/nearest_hospitals/NearestHospitalController.dart';

class NearestHospitals extends StatefulWidget {
  const NearestHospitals({Key? key}) : super(key: key);

  @override
  State<NearestHospitals> createState() => _NearestHospitalsState();
}

class _NearestHospitalsState extends State<NearestHospitals> {
  String apiKey = "AIzaSyBxbgRcWbkPHjGOnDPTLLhu5PCX_079WQY";
  String radius = "20";

  //hardcoded for now
  double latitude = 57.1526540101238;
  double longitude = -2.103119242193029;

  NearestHospitalResp nearestHospitalsResponse = NearestHospitalResp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.local_hospital_outlined),
            SizedBox(height: 8),
            Text("Find the nearest hospitals"),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              child: const Text("Nearby Hospitals"),
              onPressed: () {
                getNearestHospitals();
              },
              style: ElevatedButton.styleFrom(
                  padding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  shape: StadiumBorder(),
                  textStyle: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            if (nearestHospitalsResponse.results != null)
              for (int i = 0; i < nearestHospitalsResponse.results!.length; i++)
                nearestHospitalWidget(nearestHospitalsResponse.results![i])
          ],
        ),
      ),
    );
  }

  void getNearestHospitals() async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=hospital&location=57.1526540101238%2C-2.103119242193029&radius=1500&type=hospital&key=AIzaSyBJanXItPvUbPv6FGOHGP5h3cm4kdYsPeY');
    var response = await http.post(url);

    nearestHospitalsResponse =
        NearestHospitalResp.fromJson(jsonDecode(response.body));

    setState(() {});
  }

  Widget nearestHospitalWidget(Results results) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text("Name: " + results.name!),
          Text("Location: " +
              results.geometry!.location!.lat.toString() +
              " , " +
              results.geometry!.location!.lng.toString()),
          Text(results.openingHours != null ? "Open" : "Closed"),
        ],
      ),
    );
  }
}
