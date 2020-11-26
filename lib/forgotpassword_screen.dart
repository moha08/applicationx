import 'package:flutter/material.dart';
import 'package:applicationx/login_screen.dart';
import './backend/login.dart';
import './metadata/strings_enum.dart';
import './metadata/images_path_enum.dart';
import './custom_text_field.dart';
import './show_dialog.dart';
import './metadata/errors_enum.dart';

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
          title: Text(StringEnum.FORGOT_PASSWORD_TEXT),
        ),
        body: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                  nameController: emailController,
                  textFieldIcon: Icon(Icons.mail),
                  isSecureText: false,
                  onCompleteTextField: resetPassword,
                ),
                Container(
                    height: 80,
                    padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.green,
                      child: Text(
                        StringEnum.SEND_BUTTON_TEXT,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: resetPassword,
                    ))
              ],
            )));
  }

  void resetPassword() {
    if (emailController.text.isEmpty) {
      ShowDialogMessage.dialogShow(
        context,
        ErrorEnum.EMPTY_STRING_ERROR,
        "Message",
      );
      return;
    }

    login.resetPassword(emailController.text);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    ); //signup screen
  }
}
