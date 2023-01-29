import 'package:flutter/material.dart';

class Doctor {
  String name;
  String type;
  String info;
  String star;
  String imageUrl;
  int startHour;
  int endHour;

  Doctor(
      {required this.name,
      required this.type,
      required this.info,
      required this.star,
      required this.imageUrl,
      required this.startHour,
      required this.endHour});
}

List<Doctor> doctorsList = [
  Doctor(
      name: "Doctor 1 Olly",
      type: "Dentist",
      info:
          "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.",
      star: "4.9",
      imageUrl: "img/doctors/doc1.jpg",
      startHour: 14,
      endHour: 17),
  Doctor(
      name: "Doctor Ilhan",
      type: "Ear Doctor",
      info:
          "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.",
      star: "4.9",
      imageUrl: "img/doctors/doc2.jpg",
      startHour: 10,
      endHour: 19),
  Doctor(
      name: "Doctor Rebecca",
      type: "Heart Doctor",
      info:
          "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.",
      star: "5",
      imageUrl: "img/doctors/doc3.jpg",
      startHour: 15,
      endHour: 19),
  Doctor(
      name: "Doc4",
      type: "Eye Doctor",
      info:
          "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga.",
      star: "4.8",
      imageUrl: "img/doctors/doc4.jpg",
      startHour: 8,
      endHour: 12)
];
