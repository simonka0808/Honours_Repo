import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_honours/assets/booking_confirmation_box.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../assets/missing_fields_box.dart';

class AppointmentDetails extends StatefulWidget {
  @override
  _AppointmentDetailsState createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
  String userPhoneNumber = '';
  String healthRecordURL = '';
  final currentUser = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Provide some details about your case!"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 15),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Description",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.blueAccent.shade400),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 40),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: descriptionController,
                  decoration: InputDecoration(hintText: "What`s the problem? "),
                ), // optional
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Please upload your most recent health record",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.blueAccent.shade400),
                    ),
                    SizedBox(height: 20),
                    IconButton(
                      onPressed: () async {
                        ImagePicker imagePickerObject = ImagePicker();
                        XFile? healthRecordImage = await imagePickerObject
                            .pickImage(source: ImageSource.camera);
                        print('${healthRecordImage?.path}');

                        if (healthRecordImage == null) return;

                        String uniqueHealthRecordImageName =
                            DateTime.now().millisecondsSinceEpoch.toString();

                        Reference healthRecordsRoot =
                            FirebaseStorage.instance.ref();
                        Reference referenceDirImages = healthRecordsRoot
                            .child("past_health_records_collection");

                        Reference healthRecordToUpload = referenceDirImages
                            .child(uniqueHealthRecordImageName);

                        try {
                          await healthRecordToUpload
                              .putFile(File(healthRecordImage!.path));
                          healthRecordURL =
                              await healthRecordToUpload.getDownloadURL();
                          print("Successfully added image");
                        } catch (error) {
                          print(error.toString());
                          print("Unsuccessful");
                        }
                      },
                      icon: Icon(Icons.camera_alt),
                      iconSize: 40,
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 40, right: 40),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Please enter your phone number",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.blueAccent.shade400),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: width * 0.8,
                child: IntlPhoneField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  initialCountryCode: 'GB',
                  onChanged: (phone) {
                    print(phone.completeNumber);
                    setState(() {
                      userPhoneNumber = phone.completeNumber;
                    });
                  },
                ),
              ),
              SizedBox(
                width: 220,
                height: 50,
                child: ElevatedButton(
                  child: const Text("Submit"),
                  onPressed: () {
                    Map<String, String> apptDetailsData = {
                      'uid': currentUser.currentUser!.email.toString(),
                      'description':
                          "${descriptionController.text}", //just passing null for now
                      'healthRecordURL': "${healthRecordURL}",
                      'userPhoneNumber': "${userPhoneNumber}",
                    };
                    FirebaseFirestore.instance
                        .collection('appointment_details')
                        .add(apptDetailsData);

                    // int len = 0;
                    // if (descriptionController.text.isNotEmpty &&
                    //     phoneNumberController.text.isNotEmpty) {
                    Navigator.of(context).pop(true);

                    ///! not this
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => BookingConfirmation()));
                    // }
                    // if (descriptionController.text.length != len ||
                    //     userPhoneNumber.isEmpty) {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //       builder: (context) => MissingFieldsSnackBar()));
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      textStyle: TextStyle(
                        fontSize: 20,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
