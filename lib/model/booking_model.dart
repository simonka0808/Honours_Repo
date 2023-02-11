import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'appUtil.dart';

@JsonSerializable(explicitToJson: true)
class Appointment {
  final String? apptId;
  final String? apptName;
  final int? apptDuration;
  final String? email;

  @JsonKey(
      fromJson: AppUtil.timeStampToDateTime,
      toJson: AppUtil.dateTimeToTimeStamp)
  final DateTime? bookingStart;
  @JsonKey(
      fromJson: AppUtil.timeStampToDateTime,
      toJson: AppUtil.dateTimeToTimeStamp)
  final DateTime? bookingEnd;

  Appointment(
      {this.email,
      this.apptId,
      this.apptName,
      this.bookingStart,
      this.bookingEnd,
      this.apptDuration});

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        email: json['email'],
        apptDuration: json['apptDuration'],
        apptId: json['apptId'],
        bookingEnd:
            AppUtil.timeStampToDateTime(json['bookingStart'] as Timestamp),
        bookingStart:
            AppUtil.timeStampToDateTime(json['bookingEnd'] as Timestamp),
      );
  Map<String, dynamic> toJson(Appointment appointment) => {
        'email': email,
        'apptDuration': apptDuration,
        'apptId': apptId,
        'bookingStart': AppUtil.dateTimeToTimeStamp(appointment.bookingStart),
        'bookingEnd': AppUtil.dateTimeToTimeStamp(appointment.bookingStart),
      };
}
