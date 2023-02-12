import 'package:flutter/material.dart';

class Doctor {
  String name;
  String type;
  String patients;
  String info;
  String star;
  String imageUrl;
  DateTime startHour;
  DateTime endHour;
  DateTime startBreakHour;
  DateTime endBreakHour;
  int duration;
  int experience;
  final now = DateTime.now();

  Doctor(
      {required this.name,
      required this.type,
      required this.patients,
      required this.info,
      required this.star,
      required this.startBreakHour,
      required this.endBreakHour,
      required this.imageUrl,
      required this.startHour,
      required this.endHour,
      required this.duration,
      required this.experience});
}

List<Doctor> doctorsList = [
  Doctor(
      name: "Doctor 1 Olly",
      type: "Dentist",
      patients: "1.7k",
      info:
          "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.",
      star: "4.9",
      imageUrl: "img/doctors/doc1.jpg",
      startHour: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 30),
      endHour: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 17, 0),
      duration: 15,
      experience: 14,
      startBreakHour: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 11, 0),
      endBreakHour: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 13, 30)),
  Doctor(
      name: "Doctor Ilhan",
      type: "Ear Doctor",
      patients: "4.2k",
      info:
          "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.",
      star: "3.8",
      imageUrl: "img/doctors/doc2.jpg",
      startHour: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 5, 0),
      endHour: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 15, 0),
      duration: 30,
      experience: 10,
      startBreakHour: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 12, 0),
      endBreakHour: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 13, 30)),
  Doctor(
      name: "Doctor Rebecca",
      type: "Heart Doctor",
      patients: "3.6k",
      info:
          "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.",
      star: "5",
      imageUrl: "img/doctors/doc3.jpg",
      startHour: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0),
      endHour: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 20, 0),
      duration: 30,
      experience: 20,
      startBreakHour: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 12, 0),
      endBreakHour: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 14, 30)),
  Doctor(
      name: "Doc4",
      type: "Eye Doctor",
      patients: "1.2k",
      info:
          "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.",
      star: "4.8",
      imageUrl: "img/doctors/doc4.jpg",
      startHour: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 8, 0),
      endHour: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 15, 0),
      duration: 60,
      experience: 25,
      startBreakHour: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 12, 0),
      endBreakHour: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 13, 30)),
];
