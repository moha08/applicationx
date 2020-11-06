import 'package:flutter/material.dart';

// Run application/ main Page
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(
            "ProjectX App",
          ),
        ),
        body: Container(
          //    child: CreateProfile(),
          child: Text("Welcome on ProjectX"),
        ),
      ),
    );
  }
}
