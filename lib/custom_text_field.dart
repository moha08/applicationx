import 'package:flutter/material.dart';

// Widget for Login TextFields
class CustomTextFields extends StatelessWidget {
  final TextEditingController nameController;
  final String hintText;
  final String labelText;
  final Widget textFieldIcon;
  final bool isSecureText;
  final Function onCompleteTextField;

  CustomTextFields(
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
