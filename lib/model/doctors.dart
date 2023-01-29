import 'package:flutter/material.dart';

class Doctor {
  String name;
  String type;
  String info;
  String star;
  String imageUrl;
  DateTime startHour;
  DateTime endHour;
  int duration;
  final now = DateTime.now();

  Doctor(
      {required this.name,
      required this.type,
      required this.info,
      required this.star,
      required this.imageUrl,
      required this.startHour,
      required this.endHour,
      required this.duration});
}

List<Doctor> doctorsList = [
  Doctor(
      name: "Doctor 1 Olly",
      type: "Dentist",
      info:
          "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.",
      star: "4.9",
      imageUrl: "img/doctors/doc1.jpg",
      startHour: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 6, 0),
      endHour: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 15, 0),
      duration: 15),
  Doctor(
      name: "Doctor Ilhan",
      type: "Ear Doctor",
      info:
          "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.",
      star: "4.9",
      imageUrl: "img/doctors/doc2.jpg",
      startHour: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 5, 0),
      endHour: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 15, 0),
      duration: 30),
  Doctor(
      name: "Doctor Rebecca",
      type: "Heart Doctor",
      info:
          "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.",
      star: "5",
      imageUrl: "img/doctors/doc3.jpg",
      startHour: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0),
      endHour: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 20, 0),
      duration: 30),
  Doctor(
      name: "Doc4",
      type: "Eye Doctor",
      info:
          "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.",
      star: "4.8",
      imageUrl: "img/doctors/doc4.jpg",
      startHour: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 8, 0),
      endHour: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 15, 0),
      duration: 60),
];
