import 'package:flutter/material.dart';

class CreateProfile extends StatelessWidget {
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
          ),
          CrateProfileTextField(
            labelText: "Email",
            maxSize: 20,
          ),
          CrateProfileTextField(
            labelText: "Password",
            maxSize: 50,
          ),
          CrateProfileTextField(
            labelText: "Confirm Password",
            maxSize: 50,
          ),
          OutlineButton(
            onPressed: null,
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
  CrateProfileTextField({this.labelText, this.maxSize});

  @override
  Widget build(BuildContext context) {
    return TextField(
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
