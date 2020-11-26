import 'package:applicationx/signup_screen.dart';
import 'package:applicationx/home_screen.dart';
import 'package:applicationx/forgotpassword_screen.dart';
// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//import login backend
import './backend/login.dart';
import './show_dialog.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Login login = Login();
  bool _showPassword = true;
  IconData _iconVsisble = Icons.visibility_off;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    nameController.clear();
    passwordController.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('LOGIN'),
        ),
        body: Padding(
            padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
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
                LoginTextFields(
                  hintText: 'Please enter email',
                  labelText: 'Email',
                  nameController: nameController,
                  textFieldIcon: Icon(Icons.mail),
                  isSecureText: false,
                  onCompleteTextField: () => FocusScope.of(context).nextFocus(),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: <Widget>[
                      LoginTextFields(
                        hintText: 'Please enter a password',
                        labelText: 'Password',
                        nameController: passwordController,
                        textFieldIcon: Icon(Icons.lock),
                        isSecureText: _showPassword,
                        onCompleteTextField: () => print("done"),
                      ),
                      IconButton(
                        icon: Icon(_iconVsisble),
                        onPressed: visablePassword,
                      ),
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotpasswordPage()),
                    ).then((value) {
                      nameController.clear();
                      passwordController.clear();
                    });
                    //forgot password screen
                  },
                  textColor: Colors.green,
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                    height: 60,
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.green,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        String signInStatus = "";
                        if (nameController.text.isEmpty) {
                          signInStatus = "Please fill user name";
                        } else if (passwordController.text.isEmpty) {
                          signInStatus = "Please fill password";
                        } else {
                          signInStatus = await login.signIn(
                              nameController.text, passwordController.text);
                        }

                        if (signInStatus == 'success') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          ).then((value) {
                            //clear Textfileds when push to new pages
                            nameController.clear();
                            passwordController.clear();
                          });
                        } else {
                          ShowDialogMessage.dialogShow(
                            context,
                            signInStatus,
                            "Message",
                          );
                        }
                      },
                    )),
                Container(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                            image: new AssetImage('lib/images/facebook.png')))),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text(
                      'Do not have account?',
                      style: TextStyle(fontSize: 15),
                    ),
                    FlatButton(
                      textColor: Colors.green,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        //signup screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        ).then((value) {
                          //clear Textfileds when push to new pages
                          nameController.clear();
                          passwordController.clear();
                        });
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }

  void visablePassword() {
    setState(() {
      _showPassword == false ? _showPassword = true : _showPassword = false;
      _iconVsisble == Icons.visibility_off
          ? _iconVsisble = Icons.visibility
          : _iconVsisble = Icons.visibility_off;
    });
  }
}

// Widget for Login TextFields
class LoginTextFields extends StatelessWidget {
  final TextEditingController nameController;
  final String hintText;
  final String labelText;
  final Widget textFieldIcon;
  final bool isSecureText;
  final Function onCompleteTextField;

  LoginTextFields(
      {@required this.hintText,
      @required this.labelText,
      @required this.textFieldIcon,
      @required this.nameController,
      @required this.isSecureText,
      @required this.onCompleteTextField});
//
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: TextField(
          obscureText: isSecureText, // change from mohammad abdelqader
          controller: nameController,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: textFieldIcon,
            hintStyle: TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.white70,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: Colors.green, width: 2),
            ),
            border: OutlineInputBorder(),
            labelText: labelText,
          ),
          textInputAction: TextInputAction.next,
          onEditingComplete: onCompleteTextField),
    );
  }
}
