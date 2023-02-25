class BookingModel {
  //user properties

  final String? email;

  //booking properties

  final String? apptID;

  final String apptName;

  final int apptDuration;

  double apptLng;

  double apptLat;

  String hospitalName;

  // final String? description;

  DateTime apptStart;

  DateTime apptEnd;

  //doctor properties

  String doctorName;
  String doctorType;

  BookingModel({
    this.email,
    required this.apptDuration,
    required this.apptStart,
    required this.apptEnd,
    required this.doctorName,
    required this.doctorType,
    this.apptID,
    required this.apptLat,
    required this.apptLng,
    // this.description,
    required this.hospitalName,
    required this.apptName,
  });

  BookingModel.fromJson(Map<String, dynamic> json)
      : email = json['email'] as String?,
        apptStart = DateTime.parse(json['bookingStart'] as String),
        apptEnd = DateTime.parse(json['bookingEnd'] as String),
        apptID = json['apptID'] as String?,
        apptDuration = json['apptDuration'] as int,
        apptName = json['apptName'] as String,
        doctorType = json['doctorType'] as String,
        apptLat = json['apptLat'] as double,
        apptLng = json['apptLat'] as double,
        hospitalName = json['hospitalName'] as String,
        doctorName = json['doctorName'] as String;
  // description = json['description'] as String;

  Map<String, dynamic> toJson() => {
        'email': email,
        'apptID': apptID,
        'apptDuration': apptDuration,
        'apptName': apptName,
        'doctorType': doctorType,
        'apptLat': apptLat.toDouble(),
        'apptLng': apptLng.toDouble(),
        'bookingStart': apptStart.toIso8601String(),
        'bookingEnd': apptEnd.toIso8601String(),
        'hospitalName': hospitalName,
        'doctorName': doctorName
        // 'description': description
      };
}
