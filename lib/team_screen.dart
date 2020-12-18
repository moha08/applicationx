import 'package:applicationx/join_team.dart';
import 'package:applicationx/teamlist_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:applicationx/addteam_screen.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class TeamPage extends StatefulWidget {
  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('TEAMS LIST'), backgroundColor: Colors.green),
      body: count == 0 ? NoTeamsWidget(count: count) : TeamlistPage(),
      floatingActionButton: SpeedDial(
        // both default to 16
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
        //visible: _dialVisible,
        // If true user is forced to close dial manually
        // by tapping main button and overlay is not rendered.
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('Team Management opened'),
        onClose: () => print('Team Management Closed'),
        tooltip: 'Team',
        //heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.add),
              backgroundColor: Colors.green,
              label: 'Add Team',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AddteamPage()),
                );
              }),
          SpeedDialChild(
              child: Icon(Icons.group_add),
              backgroundColor: Colors.pink,
              label: 'Join Team',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => JoinTeam()),
                );
              }),
        ],
      ),
    );
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
                    'NO TEAM',
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
