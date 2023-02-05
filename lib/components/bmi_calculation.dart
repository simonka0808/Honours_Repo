import 'dart:math';

import 'package:flutter/material.dart';

class BMICalculation {
  BMICalculation({required this.weight, required this.height});

  final int weight;
  final double height;

  double bmi_output = 0;

  String bmiCalculateResult() {
    bmi_output = (weight / pow(height / 100, 2));
    return bmi_output.toStringAsFixed(1);
  }

  String bmiCategory() {
    if (bmi_output >= 25) {
      return 'Overweight';
    } else if (bmi_output > 30) {
      return "Obese";
    } else if (bmi_output > 18.5) {
      return 'Healthy weight';
    } else {
      return 'Underweight';
    }
  }

  String bmiAdvice() {
    if (bmi_output >= 25) {
      return 'You are slightly overweight. You may be advised to lose some weight for healthy reasons';
    } else if (bmi_output > 18.5) {
      return 'Good job! You are at a healthy weight for your height!';
    } else if (bmi_output > 30) {
      return 'You are heavily overweight! You are recommended to talk to your doctor'!;
    } else {
      return 'You have a lower than normal body weight.\n You need to gain some weight';
    }
  }

  Color getTextColor() {
    if (bmi_output >= 25 || bmi_output <= 18.5) {
      return Colors.deepOrangeAccent;
    } else {
      return Color(0xFF24D876);
    }
  }
}
