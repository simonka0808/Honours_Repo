import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../assets/category_skeleton.dart';
import '../screens/profile_page.dart';
import '../widgets/doctors_screen.dart';

class WelcomePage extends StatelessWidget {
  String email;
  WelcomePage({Key? key, required this.email}) : super(key: key);

  List categories = [
    "Cardiologist",
    "Dentist",
    "Psychologist",
    "Pharmacy",
  ];

  List<Icon> categoriesIcons = [
    Icon(MdiIcons.heartPlus, color: Colors.white, size: 30),
    Icon(MdiIcons.toothOutline, color: Colors.white, size: 30),
    Icon(MdiIcons.headCogOutline, color: Colors.white, size: 30),
    Icon(MdiIcons.pill, color: Colors.white, size: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //app bar
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Text(
                              "Hi" + " " + email,
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Choose the best for you!",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15, bottom: 20),
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 7,
                                        spreadRadius: 3)
                                  ]),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search here...",
                                    hintStyle: TextStyle(color: Colors.black),
                                    prefixIcon: Icon(
                                      Icons.search,
                                      size: 25,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "Categories",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 85,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CategorySkeleton(), //TODO:
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 15,
                                      ),
                                      height: 50,
                                      width: 65,
                                      decoration: BoxDecoration(
                                        color: Colors.white30,
                                        shape: BoxShape.circle,
                                        border:
                                            Border.all(color: Colors.blueGrey),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.blueAccent,
                                            blurRadius: 4,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: categoriesIcons[index],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(categories[index],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Colors.black87.withOpacity(0.7)))
                                ],
                              );
                            }),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "Our Doctors",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 10),
                      DoctorsScreen(),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
