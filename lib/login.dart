import 'package:flutter/material.dart';
import './create_profile.dart';
import './main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("lib/images/userProfile.jpeg"),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: BorderRadius.all(
                Radius.circular(2),
              ),
            ),
            child: Text(
              "ProjectX Application",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            controller: emailTextController,
            obscureText: false,
            autofocus: false,
            maxLength: 50,
            style: TextStyle(
              fontSize: 15,
            ),
            decoration: InputDecoration(
              hintText: "email",
              //labelStyle: TextStyle(color: Colors.blueGrey, fontSize: 18),
            ),
          ),
          TextField(
            controller: passwordTextController,
            obscureText: false,
            autofocus: false,
            maxLength: 50,
            style: TextStyle(
              fontSize: 15,
            ),
            decoration: InputDecoration(
              hintText: "password",
              //labelStyle: TextStyle(color: Colors.blueGrey, fontSize: 18),
            ),
          ),
          Row(
            children: [
              Checkbox(value: true, onChanged: null),
              Text("Remember me")
            ],
          ),
          OutlineButton(
            onPressed: () async {
              try {
                UserCredential userCredential = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: emailTextController.text,
                        password: passwordTextController.text);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  print('No user found for that email.');
                } else if (e.code == 'wrong-password') {
                  print('Wrong password provided for that user.');
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.lightBlue[300],
                ),
              ),
            ),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account ?"),
              FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateProfile()),
                    );
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.blue[300],
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
