import 'package:flutter/material.dart';
import 'package:applicationx/login_screen.dart';
import './beans/users.dart';
import './backend/login.dart';
import 'package:country_code_picker/country_code_picker.dart';
import './custom_text_field.dart';
import './show_dialog.dart';
import './metadata/strings_enum.dart';
import './metadata/images_path_enum.dart';
import './metadata/errors_enum.dart';

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
          title: Text(StringEnum.SIGN_UP_TITLE),
        ),
        body: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ListView(
              children: <Widget>[
                Image(
                  image: AssetImage(ImagesPathEnum.USER_PROFILE_IMG),
                  height: 200,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                  child: Image(
                    image: AssetImage(ImagesPathEnum.PRODUCT_NAME_IMG),
                  ),
                ),
                Container(
                    height: 40,
                    child: Text(
                      StringEnum.CREATE_NEW_ACCT_TEXT,
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )),
                CustomTextFields(
                  hintText: StringEnum.FULL_NAME_HINT_TEXT,
                  isSecureText: false,
                  labelText: StringEnum.FULL_NAME_LABEL_TEXT,
                  nameController: fullNameController,
                  onCompleteTextField: () => FocusScope.of(context).nextFocus(),
                  textFieldIcon: Icon(Icons.contact_page),
                ),
                CustomTextFields(
                  hintText: StringEnum.EMAIL_HINT_TEXT,
                  isSecureText: false,
                  labelText: StringEnum.EMAIL_LABEL_TEXT,
                  nameController: emailController,
                  onCompleteTextField: () => FocusScope.of(context).nextFocus(),
                  textFieldIcon: Icon(Icons.email),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      CustomTextFields(
                        hintText: StringEnum.MOBILE_HINT_TEXT,
                        isSecureText: false,
                        labelText: StringEnum.MOBILE_LABEL_TEXT,
                        nameController: mobileNumberController,
                        onCompleteTextField: () =>
                            FocusScope.of(context).nextFocus(),
                        textFieldIcon: Icon(Icons.mobile_screen_share),
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
                      CustomTextFields(
                        hintText: StringEnum.PASSWORD_HINT_TEXT,
                        isSecureText: _showPassword,
                        labelText: StringEnum.PASSWORD_LABEL_TEXT,
                        nameController: passwordController,
                        onCompleteTextField: () =>
                            FocusScope.of(context).nextFocus(),
                        textFieldIcon: Icon(Icons.lock),
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
                        CustomTextFields(
                          hintText: StringEnum.PASSWORD_CONFIRM_HINT_TEXT,
                          isSecureText: _showPassword,
                          labelText: StringEnum.PASSWORD_CONFIRM_LABEL_TEXT,
                          nameController: confirmPasswordController,
                          onCompleteTextField: () =>
                              FocusScope.of(context).nextFocus(),
                          textFieldIcon: Icon(Icons.lock),
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
                        StringEnum.SIGN_UP_TEXT,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: signUpFun,
                    )),
              ],
            )));
  }

  void signUpFun() async {
    if (passwordController.text != confirmPasswordController.text) {
      ShowDialogMessage.dialogShow(
        context,
        ErrorEnum.CONFIRM_PASSWORD_STRING_ERROR,
        "Error",
      );
      return;
    }
    Users user = Users(
        fullName: fullNameController.text,
        email: emailController.text,
        mobileNumber: int.parse(mobileNumberController.text),
        password: passwordController.text);

    String sigUpResult = await login.signUp(user);
    print(sigUpResult);

    if (sigUpResult == 'success') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      ShowDialogMessage.dialogShow(
        context,
        sigUpResult,
        "Error",
      );
    }
  }
}
