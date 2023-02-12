import 'package:flutter/material.dart';
import 'package:test_honours/model/doctors.dart';

import 'appointment_screen.dart';

class DoctorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // double h = MediaQuery.of(context).size.height;

    return Container(
      height: 300,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: doctorsList.length,
          itemBuilder: (context, index) {
            Doctor doctor = doctorsList[index];
            return Column(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.purple,
                            blurRadius: 5,
                            spreadRadius: 3)
                      ]),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AppointmentScreen(
                                      doctor,
                                      currentDoctorIndex: index), //TODO:
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              child: Image.asset(
                                doctor.imageUrl,
                                height: 120,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              margin: EdgeInsets.all(8),
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white30,
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.favorite_outline,
                                  color: Colors.black87,
                                  size: 30,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(children: [
                          Text(
                            doctor.name,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent),
                          ),
                          Text(
                            doctor.type,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black87.withOpacity(0.5),
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 34),
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              SizedBox(width: 5),
                              Text(
                                doctor.star,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87.withOpacity(0.5)),
                              )
                            ],
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
