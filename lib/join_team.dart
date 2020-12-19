import 'package:applicationx/teamhome_screen.dart';
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
  bool _validate = false;
  TextEditingController teamCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('JOIN A TEAM'),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.close),
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TeamHomePage()),
              ),
            ),
          ],
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
                    hintStyle: TextStyle(color: Colors.grey),
                    errorText: _validate ? 'Value Can\'t Be Empty' : null,
                    //suffixIcon: Icon(Icons.contact_page),
                    filled: true,
                    fillColor: Colors.white70,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: Colors.green, width: 2),
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Team Code',
                  ),
                  onChanged: (value) {
                    setState(() {
                      _validate = false;
                    });
                  },
                ),
              ),
              Container(
                height: 80,
                padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
                child: RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  label: Text(
                    'Join',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  icon: Icon(
                    Icons.group_add,
                    color: Colors.white,
                  ),
                  textColor: Colors.white,
                  splashColor: Colors.red,
                  color: Colors.green,
                  onPressed: joinTeam,
                ),
              ),
            ],
          ),
        ));
  }

  Future joinTeam() async {
    setState(() {
      teamCodeController.text.isEmpty ? _validate = true : _validate = false;
    });

    if (_validate == false) {
      EasyLoading.show(
        status: 'loading...',
      );
      String str = await Teams().joinTeam(teamCodeController.text);
      if (str == 'success') {
        EasyLoading.dismiss();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TeamPage()),
        ).then((value) {
          setState(() {});
        });
      } else if (str == "wrongID") {
        ShowDialogMessage.dialogShow(
          context,
          "Please check the Team Code with admin",
          "Message",
        );
        EasyLoading.dismiss();
      } else {
        ShowDialogMessage.dialogShow(
          context,
          str,
          "Message",
        );
        EasyLoading.dismiss();
      }
    }
  }
}
