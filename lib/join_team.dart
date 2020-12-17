import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import './backend/teams.dart';
import 'show_dialog.dart';
import 'package:applicationx/team_screen.dart';

class JoinTeam extends StatefulWidget {
  @override
  _JoinTeamState createState() => _JoinTeamState();
}

class _JoinTeamState extends State<JoinTeam> {
  TextEditingController teamCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New Team'),
        ),
        body: Padding(
          padding: EdgeInsets.all(50),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  obscureText: false,
                  controller: teamCodeController,
                  decoration: InputDecoration(
                    hintText: 'Please enter a team code',
                    //suffixIcon: Icon(Icons.contact_page),
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white70,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: Colors.green, width: 2),
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Team Code',
                  ),
                ),
              ),
              Container(
                  height: 80,
                  padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.green,
                    child: Text(
                      'Join Team',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: joinTeam,
                  ))
            ],
          ),
        ));
  }

  Future joinTeam() async {
    EasyLoading.show(
      status: 'loading...',
    );
    String str = await Teams().joinTeam("rItxR");
    if (str == 'success') {
      EasyLoading.dismiss();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TeamPage()),
      ).then((value) {
        setState(() {});
      });
    } else {
      ShowDialogMessage.dialogShow(
        context,
        str,
        "Message",
      );
    }
  }
}
