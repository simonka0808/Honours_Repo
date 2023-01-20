import 'package:flutter/material.dart';

class DoctorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // double h = MediaQuery.of(context).size.height;

    return Container(
      height: 300,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  height: 240,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              child: Image.asset(
                                "img/doctors/doc${index + 1}.jpg",
                                height: 200,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              margin: EdgeInsets.all(8),
                              height: 45,
                                width: 45,
                              decoration: ,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
