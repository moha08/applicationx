import 'package:applicationx/signup_screen.dart';
import 'package:applicationx/home_screen.dart';
import 'package:applicationx/forgotpassword_screen.dart';
import 'package:flutter/material.dart';

//import login backend
import './backend/login.dart';

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
                Container(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    obscureText: false, // change from mohammad abdelqader
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Please enter username or email',
                      suffixIcon: Icon(Icons.contact_mail),
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white70,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.green, width: 2),
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'Username or Email',
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
                          // suffixIcon: Icon(Icons.visibility_off),

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
                        textInputAction: TextInputAction.done,
                        onEditingComplete: () => print("done"),
                      ),
                      IconButton(
                        icon: Icon(_iconVsisble),
                        onPressed: () {
                          setState(() {
                            _showPassword == true
                                ? _showPassword = false
                                : _showPassword = true;

                            _iconVsisble == Icons.visibility_off
                                ? _iconVsisble = Icons.visibility_off
                                : _iconVsisble = Icons.visibility;
                          });
                        },
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
                    );
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
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
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
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Message"),
                                  content: Text(signInStatus),
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
}
