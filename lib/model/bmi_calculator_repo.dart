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

  // 4
  updatePet(BMICalculatorModel bmiCalculator) async {
    await collection
        .doc(bmiCalculator.reference.id)
        .set(bmiCalculator.toJson());
  }
}
