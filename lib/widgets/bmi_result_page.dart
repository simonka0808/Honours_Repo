import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String resultText;
  final String bmiNumber;
  final String advise;
  final Color textColor;

  ResultPage(
      {required this.textColor,
      required this.resultText,
      required this.bmiNumber,
      required this.advise});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(children: [
          Container(
            width: width,
            height: 70,
            color: Colors.lightBlue,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Your BMI Results",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 70)),
          Container(
            padding: EdgeInsets.only(top: 70),
            width: width,
            height: 8,
            color: Colors.blueGrey,
          ),
          Text(
            resultText,
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Text(
            bmiNumber,
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Text(
            advise,
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Container(
            width: width,
            height: 8,
            color: Colors.blueGrey,
          ),
        ]),
      ),
    );
  }
}
