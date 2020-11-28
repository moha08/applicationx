import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:applicationx/addteam_screen.dart';

class TeamPage extends StatelessWidget {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Teams List'), backgroundColor: Colors.green),
        body: Column(
          children: <Widget>[
            //icon with label below it
            Container(
              padding: EdgeInsets.fromLTRB(30, 280, 30, 60),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(children: <Widget>[
                      count == 0
                          ? Icon(Icons.person_add_disabled,
                              size: 80, color: Colors.grey)
                          : Text("List1"),
                      Text(
                        'No Team',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ]),
                  ]),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddteamPage()),
              );
            }));
  }
}
