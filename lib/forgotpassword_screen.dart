import 'package:flutter/material.dart';
import 'package:applicationx/login_screen.dart';
import './backend/login.dart';

class ForgotpasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

// hamoda test 2
class _State extends State<ForgotpasswordPage> {
  TextEditingController emailController = TextEditingController();

  // initalise login object
  Login login = Login();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FORGOT PASSWORD'),
        ),
        body: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ListView(
              children: <Widget>[
                Image(
                  image: AssetImage("lib/images/userProfile.jpeg"),
                  height: 300,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                  child: Image(
                    image: AssetImage("lib/images/productName2.jpeg"),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    obscureText: false,
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Please enter your email',
                      suffixIcon: Icon(Icons.mail),
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white70,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.green, width: 2),
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                    height: 80,
                    padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.green,
                      child: Text(
                        'Send',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        login.resetPassword(emailController.text);

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        ); //signup screen
                      },
                    ))
              ],
            )));
  }
}
