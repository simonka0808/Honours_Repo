import 'package:cloud_firestore/cloud_firestore.dart';

import 'bmi_calculator_model.dart';

class DataRepository {
  // 1
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('bmi_calculator');
  // 2
  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  // 3
  Future<DocumentReference> addBMI(BMICalculatorModel bmiCalculator) {
    return collection.add(bmiCalculator.toJson());
  }

  Future<void> addWeight() {
    return collection.doc('bmi_calculator').set({'weight': 0});
  }
}
