import 'dart:async';

import 'package:applicationx/signup_screen.dart';
import 'package:applicationx/home_screen.dart';
import 'package:applicationx/forgotpassword_screen.dart';
// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//import login backend
import 'backend/login.dart';
import 'show_dialog.dart';
import 'metadata/errors_enum.dart';
import 'metadata/strings_enum.dart';
import 'metadata/images_path_enum.dart';
import 'custom_text_field.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginPageMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: LoginPage(),
      builder: EasyLoading.init(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  Timer _timer;
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
          title: Text(StringEnum.LOGON_TITLE),
        ),
        body: Padding(
            padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
            child: ListView(
              children: <Widget>[
                Image(
                  image: AssetImage(ImagesPathEnum.USER_PROFILE_IMG),
                  height: 300,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                  child: Image(
                    image: AssetImage(ImagesPathEnum.PRODUCT_NAME_IMG),
                  ),
                ),
                CustomTextFields(
                  hintText: StringEnum.EMAIL_HINT_TEXT,
                  labelText: StringEnum.EMAIL_LABEL_TEXT,
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
                      CustomTextFields(
                        hintText: StringEnum.PASSWORD_HINT_TEXT,
                        labelText: StringEnum.PASSWORD_LABEL_TEXT,
                        nameController: passwordController,
                        textFieldIcon: Icon(Icons.lock),
                        isSecureText: _showPassword,
                        onCompleteTextField: loginFun,
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
                    StringEnum.FORGOT_PASSWORD_TEXT,
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
                        StringEnum.LOGIN_TEXT,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: loginFun,
                    )),
                Container(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                            image: new AssetImage(
                      ImagesPathEnum.FACEBOOK_IMG,
                    )))),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text(
                      StringEnum.ACCOUNT_QUESTION_TEXT,
                      style: TextStyle(fontSize: 15),
                    ),
                    FlatButton(
                      textColor: Colors.green,
                      child: Text(
                        StringEnum.SIGN_UP_TEXT,
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

  void loginFun() async {
    configIndicator();

    await EasyLoading.show(
      status: 'loading...',
    );
    String signInStatus = "";
    if (nameController.text.isEmpty || passwordController.text.isEmpty) {
      signInStatus = ErrorEnum.EMPTY_STRING_ERROR;
    } else {
      signInStatus =
          await login.signIn(nameController.text, passwordController.text);
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

    _timer?.cancel();
    EasyLoading.dismiss();
  }

  void configIndicator() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.white
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskColor = Colors.green.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
  }
}
