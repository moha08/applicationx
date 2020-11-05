import 'package:flutter/material.dart';
import './beans/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateProfile extends StatefulWidget {
  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  // define text controller
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
            height: 15,
          ),
          Container(
            width: double.infinity,
            child: Text(
              "Create New Account",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CrateProfileTextField(
            labelText: "Full Name",
            maxSize: 50,
            controller: fullNameController,
          ),
          CrateProfileTextField(
            labelText: "Email",
            maxSize: 20,
            controller: emailController,
          ),
          CrateProfileTextField(
            labelText: "Password",
            maxSize: 50,
            controller: passwordController,
          ),
          CrateProfileTextField(
            labelText: "Confirm Password",
            maxSize: 50,
          ),
          OutlineButton(
            onPressed: () async {
              try {
                UserCredential userCredential = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text);
                /* User(
                  fullName: fullNameController.text,
                  email: emailController.text,
                  password: passwordController.text,
                ).addUser();*/
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  print('The password provided is too weak.');
                } else if (e.code == 'email-already-in-use') {
                  print('The account already exists for that email.');
                }
              } catch (e) {
                print(e);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.lightBlue[300],
                ),
              ),
            ),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0),
            ),
          )
        ],
      ),
    );
  }
}

class CrateProfileTextField extends StatelessWidget {
  final String labelText;
  final int maxSize;
  final TextEditingController controller;
  CrateProfileTextField({this.labelText, this.maxSize, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: false,
      autofocus: false,
      maxLength: maxSize,
      style: TextStyle(
        fontSize: 15,
      ),
      decoration: InputDecoration(
        hintText: labelText,
        //labelStyle: TextStyle(color: Colors.blueGrey, fontSize: 18),
      ),
    );
  }
}
