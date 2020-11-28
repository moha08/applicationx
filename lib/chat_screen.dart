import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: count == 0 ? Text("No Event") : Text("List1"),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatPage()),
              );
            }));
  }
}
