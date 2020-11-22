/* import 'package:flutter/material.dart';
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
}*/

import "package:flutter/material.dart";
import 'login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.green), home: LoginPage());
  }
}
