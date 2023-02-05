import 'package:flutter/material.dart';
import 'package:test_honours/components/bmi_calculation.dart';
import 'package:test_honours/widgets/bmi_result_page.dart';
import 'package:weight_slider/weight_slider.dart';

import '../model/bmi_calculator_repo.dart';

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final DataRepository repository = DataRepository();

  int weight = 60;
  double height = 165;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: width,
              height: 70,
              color: Colors.lightBlue,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "BMI Calculator",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 35),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Weight (kg)",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.blueAccent.shade400),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 40),
              child: WeightSlider(
                weight: weight,
                minWeight: 40,
                maxWeight: 120,
                onChange: (val) => setState(() => this.weight = val),
                unit: 'kg', // optional
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 35),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Height (cm)",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.blueAccent.shade400),
                ),
              ),
            ),
            Slider(
              value: height.toDouble(),
              min: 110.0,
              max: 240.0,
              onChanged: (double value) {
                setState(() {
                  this.height = value;
                });
              },
            ),
            Container(
              padding: EdgeInsets.only(top: 35),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  height.round().toString() + " cm",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent.shade400),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(40)),
            SizedBox(
              width: 220,
              height: 50,
              child: ElevatedButton(
                child: const Text("Calculate"),
                onPressed: () {
                  BMICalculation calculation =
                      BMICalculation(weight: weight, height: height);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultPage(
                        bmiNumber: calculation.bmiCalculateResult(),
                        resultText: calculation.bmiCategory(),
                        advise: calculation.bmiAdvice(),
                        textColor: calculation.getTextColor(),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    shape: StadiumBorder(),
                    textStyle: TextStyle(
                      fontSize: 20,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
