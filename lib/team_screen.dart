import 'package:applicationx/teamlist_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:applicationx/addteam_screen.dart';

class TeamPage extends StatelessWidget {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('TEAMS LIST'), backgroundColor: Colors.green),
        body: count == 0 ? NoTeamsWidget(count: count) : TeamlistPage(),
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

class NoTeamsWidget extends StatelessWidget {
  const NoTeamsWidget({
    Key key,
    @required this.count,
  }) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //icon with label below it
        Container(
          padding: EdgeInsets.fromLTRB(30, 280, 30, 60),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(children: <Widget>[
                  Icon(Icons.person_add_disabled, size: 80, color: Colors.grey),
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
    );
  }
}
