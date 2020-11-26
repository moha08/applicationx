import 'package:flutter/material.dart';

class ShowDialogMessage {
  static Future dialogShow(
      BuildContext context, String dialogMessage, String messageType) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(messageType),
            content: Text(dialogMessage),
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
}
