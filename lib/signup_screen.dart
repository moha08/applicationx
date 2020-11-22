import 'package:flutter/material.dart';
import 'package:applicationx/login_screen.dart';
import './beans/users.dart';
import './backend/login.dart';
import 'package:country_code_picker/country_code_picker.dart';

class SignupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  bool _showPassword = true;
  bool _showConfirmPassword = true;
  IconData _iconVsisble = Icons.visibility_off;
  IconData _iconVisible = Icons.visibility_off;

  // initalise login object
  Login login = Login();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SIGN UP'),
        ),
        body: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ListView(
              children: <Widget>[
                Image(
                  image: AssetImage("lib/images/userProfile.jpeg"),
                  height: 200,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                  child: Image(
                    image: AssetImage("lib/images/productName2.jpeg"),
                  ),
                ),
                Container(
                    height: 40,
                    child: Text(
                      'Create New Account',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )),
                Container(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    obscureText: false,
                    controller: fullNameController,
                    decoration: InputDecoration(
                      hintText: 'Please enter a full name',
                      prefixIcon: Icon(Icons.contact_page),
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white70,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.green, width: 2),
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'Full Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    obscureText: false,
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Please enter email',
                      prefixIcon: Icon(Icons.email),
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
                  padding: EdgeInsets.all(5),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      TextField(
                        obscureText: false,
                        controller: mobileNumberController,
                        decoration: InputDecoration(
                          hintText: 'Please enter a mobile number',
                          prefixIcon: Icon(Icons.mobile_screen_share),
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white70,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            borderSide:
                                BorderSide(color: Colors.green, width: 2),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Mobile Number',
                        ),
                      ),
                      CountryCodePicker(
                        onChanged: print,
                        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                        initialSelection: 'JO',
                        favorite: ['+962', 'JO'],
                        // optional. Shows only country name and flag
                        showCountryOnly: false,
                        // optional. Shows only country name and flag
                        showOnlyCountryWhenClosed: false,
                        // optional. Shows only country name and flag when popup is closed.
                        showFlag: true,
                        // showFlagDialog: true,
                        flagWidth: 25.0,
                        // optional. aligns the flag and the Text left
                        alignLeft: false,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: <Widget>[
                      TextField(
                        obscureText: _showPassword,
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: 'Please enter a password',
                          prefixIcon: Icon(Icons.lock),
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.white70,
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            borderSide:
                                BorderSide(color: Colors.green, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: Colors.green, width: 2),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                      IconButton(
                        icon: Icon(_iconVsisble),
                        onPressed: () {
                          setState(() {
                            _showPassword == false
                                ? _showPassword = true
                                : _showPassword = false;
                            _iconVsisble == Icons.visibility_off
                                ? _iconVsisble = Icons.visibility
                                : _iconVsisble = Icons.visibility_off;
                          });
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Stack(
                      alignment: Alignment.centerRight,
                      children: <Widget>[
                        TextField(
                          obscureText: _showConfirmPassword,
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                            hintText: 'Please confirm password',
                            prefixIcon: Icon(Icons.lock),
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.white70,
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide:
                                  BorderSide(color: Colors.green, width: 2),
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'Confirm Password',
                          ),
                        ),
                        IconButton(
                          icon: Icon(_iconVisible),
                          onPressed: () {
                            setState(() {
                              _showConfirmPassword == false
                                  ? _showConfirmPassword = true
                                  : _showConfirmPassword = false;
                              _iconVisible == Icons.visibility_off
                                  ? _iconVisible = Icons.visibility
                                  : _iconVisible = Icons.visibility_off;
                            });
                          },
                        )
                      ]),
                ),
                Container(
                    height: 80,
                    padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.green,
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        if (passwordController.text !=
                            confirmPasswordController.text) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Error"),
                                  content: Text(
                                      "password and confirm password do not match"),
                                  actions: [
                                    FlatButton(
                                      child: Text("Ok"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                          return;
                        }
                        Users user = Users(
                            fullName: fullNameController.text,
                            email: emailController.text,
                            mobileNumber:
                                int.parse(mobileNumberController.text),
                            password: passwordController.text);

                        String sigUpResult = await login.signUp(user);
                        print(sigUpResult);

                        if (sigUpResult == 'success') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Error"),
                                  content: Text(sigUpResult),
                                  actions: [
                                    FlatButton(
                                      child: Text("Ok"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        }
                      },
                    )),
              ],
            )));
  }
}
