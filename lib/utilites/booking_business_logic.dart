import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:test_honours/components/booking_calendar/booking_service.dart';

class BusinessLogic extends GetxService {
  static BusinessLogic to = Get.find<BusinessLogic>();

  CollectionReference bookings =
      FirebaseFirestore.instance.collection('client_bookings');

  Future<BusinessLogic> init() async {
    return this;
  }

  CollectionReference<BookingModel> getBookingStream(
      {required String placeId}) {
    return bookings
        .doc(placeId)
        .collection('client_bookings')
        .withConverter<BookingModel>(
          fromFirestore: (snapshots, _) =>
              BookingModel.fromJson(snapshots.data()!),
          toFirestore: (snapshots, _) => snapshots.toJson(),
        );
  }
}
