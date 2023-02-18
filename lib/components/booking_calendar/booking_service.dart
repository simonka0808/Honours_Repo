class BookingModel {
  //user properties

  final String? email;

  //booking properties

  final String? apptID;

  final String apptName;

  final int apptDuration;

  // final String? description;

  DateTime apptStart;

  DateTime apptEnd;

  //doctor properties

  String doctorName;

  BookingModel({
    this.email,
    required this.apptDuration,
    required this.apptStart,
    required this.apptEnd,
    required this.doctorName,
    this.apptID,
    // this.description,
    required this.apptName,
  });

  BookingModel.fromJson(Map<String, dynamic> json)
      : email = json['email'] as String?,
        apptStart = DateTime.parse(json['bookingStart'] as String),
        apptEnd = DateTime.parse(json['bookingEnd'] as String),
        apptID = json['apptID'] as String?,
        apptDuration = json['apptDuration'] as int,
        apptName = json['apptName'] as String,
        doctorName = json['doctorName'] as String;
  // description = json['description'] as String;

  Map<String, dynamic> toJson() => {
        'email': email,
        'apptID': apptID,
        'apptDuration': apptDuration,
        'apptName': apptName,
        'bookingStart': apptStart.toIso8601String(),
        'bookingEnd': apptEnd.toIso8601String(),
        'doctorName': doctorName
        // 'description': description
      };
}
