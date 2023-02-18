import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentManager {
  final CollectionReference appointmentList =
      FirebaseFirestore.instance.collection('client_bookings');

  Future<void> createAppointmentData(
      String bookingStart,
      String bookingEnd,
      String doctorName,
      String email,
      int apptDuration,
      String apptName) async {
    return await appointmentList.doc(email).set({
      'bookingStart': bookingStart,
      'bookingEnd': bookingEnd,
      'doctorName': doctorName,
      'apptDuration': apptDuration,
      'apptName': apptName
    });
  }

  Future getAppointmentList() async {
    List itemsList = [];
    try {
      await appointmentList.get().then((querySnapshot) {
        querySnapshot.docs.forEach(
          (element) {
            itemsList.add(element.data);
          },
        );
      });
      return appointmentList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
