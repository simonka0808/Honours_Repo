import 'package:cloud_firestore/cloud_firestore.dart';

class BMICalculatorModel {
  String bmiNumber;
  String resultText;
  String advice;

  DocumentReference reference;

  BMICalculatorModel(this.bmiNumber, this.reference, this.advice,
      {required this.resultText});

  // 4
  factory BMICalculatorModel.fromJson(Map<dynamic, dynamic> json) =>
      _BMICalculatorModelFromJson(json);
  // 5
  Map<String, dynamic> toJson() => _BMICalculatorModelToJson(this);
  @override
  String toString() => "BMI INDEX<$bmiNumber>";
}

//1
BMICalculatorModel _BMICalculatorModelFromJson(Map<dynamic, dynamic> json) {
  return BMICalculatorModel(
    json['bmiNumber'] as String,
    json['advice'],
    json['resultText'] as String,
    resultText: '',
  );
}

//2
Map<String, dynamic> _BMICalculatorModelToJson(BMICalculatorModel instance) =>
    <String, dynamic>{
      'bmiNumber': instance.bmiNumber,
      'advice': instance.advice,
      'resultText': instance.resultText,
    };
