class DoctorsGoogleSheet {
  String name;
  String type;
  String patients;
  String info;
  String hospitalName;
  DateTime startHour;
  DateTime endHour;
  DateTime startBreakHour;
  DateTime endBreakHour;
  double apptLat;
  double apptLng;
  int duration;
  int experience;

  DoctorsGoogleSheet(
      {required this.name,
      required this.type,
      required this.patients,
      required this.info,
      required this.startBreakHour,
      required this.endBreakHour,
      required this.startHour,
      required this.endHour,
      required this.duration,
      required this.apptLng,
      required this.apptLat,
      required this.hospitalName,
      required this.experience});

  factory DoctorsGoogleSheet.fromJson(dynamic json) {
    return DoctorsGoogleSheet(
        name: "${json['Name']}",
        type: "${json['Type']}",
        patients: "${json['Patients']}",
        info: "${json['Info']}",
        hospitalName: "${json['Hospital Name']}",
        startHour: DateTime.parse("${json['StartHour']}"),
        endHour: DateTime.parse("${json['EndHour']}"),
        duration: int.parse("${json['Duration']}"),
        startBreakHour: DateTime.parse("${json['StartBreakHour']}"),
        endBreakHour: DateTime.parse("${json['EndBreakHour']}"),
        apptLng: double.parse("${json['ApptLang']}"),
        apptLat: double.parse("${json['ApptLat']}"),
        experience: int.parse("${json['Experience']}"));
  }

  Map toJson() => {
        "Name": name,
        "Type": type,
        "Patients": patients,
        "Info": info,
        "StartHour": startHour,
        "EndHour": endHour,
        "Experience": experience,
        "Duration": duration,
        "ApptLang": apptLng,
        "ApptLat": apptLat,
        "StartBreakHour": startBreakHour,
        "EndBreakHour": endBreakHour
      };
}
