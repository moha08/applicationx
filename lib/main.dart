import 'package:flutter/material.dart';
import './create_profile.dart';

// Run application
void main() => runApp(ProjectxApp());

// main Page
class ProjectxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "ProjectX App",
          ),
        ),
        body: Container(
          child: CreateProfile(),
        ),
      ),
    );
  }
}
