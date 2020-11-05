import 'package:flutter/material.dart';
import './create_profile.dart';
import 'package:firebase_core/firebase_core.dart';

// Run application
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProjectxApp());
}

// main Page
class ProjectxApp extends StatelessWidget {
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
          child: CreateProfile(),
        ),
      ),
    );
  }
}
