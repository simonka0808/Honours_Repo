class BookingModel {
  //user properties

  final String? userID;

  final String? email;

  //booking properties

  final String? apptID;

  final String apptName;

  final int apptDuration;

  DateTime bookingStart;

  DateTime bookingEnd;

  BookingModel({
    this.email,
    this.userID,
    required this.apptDuration,
    required this.bookingStart,
    required this.bookingEnd,
    this.apptID,
    required this.apptName,
  });

  BookingModel.fromJson(Map<String, dynamic> json)
      : email = json['email'] as String?,
        userID = json['userID'] as String?,
        bookingStart = DateTime.parse(json['bookingStart'] as String),
        bookingEnd = DateTime.parse(json['bookingEnd'] as String),
        apptID = json['apptID'] as String?,
        apptDuration = json['apptDuration'] as int,
        apptName = json['apptName'] as String;

  Map<String, dynamic> toJson() => {
        'userID': userID,
        'email': email,
        'apptID': apptID,
        'apptDuration': apptDuration,
        'apptName': apptName,
        'bookingStart': bookingStart.toIso8601String(),
        'bookingEnd': bookingEnd.toIso8601String(),
      };
}
