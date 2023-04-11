import 'package:flutter/material.dart';

import '../model/doctors.dart';

class CategorySkeleton extends StatefulWidget {
  @override
  _CategorySkeletonState createState() => _CategorySkeletonState();
}

class _CategorySkeletonState extends State<CategorySkeleton> {
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
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: doctorsList.length,
                    itemBuilder: (context, index) {
                      Doctor doctor = doctorsList[index];
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
                                              color: Colors.blueGrey.shade100,
                                              blurRadius: 5,
                                              spreadRadius: 3)
                                        ]),
                                    child: Column(
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Stack(
                                          children: [
                                            InkWell(
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
                    }),
              ],
            ),
          ),
        ));
  }
}
