import 'package:flutter/material.dart';

class EventPage extends StatelessWidget {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Events List'), backgroundColor: Colors.green),
        body: Center(
          child: count == 0
              ? Icon(Icons.event_busy, size: 60, color: Colors.grey)
              : Text("List1"),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventPage()),
              );
            }));
  }
}
