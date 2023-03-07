import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent.shade100,
      appBar: AppBar(
        title: Text("Doctor`s background"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Work in progress",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }
}
