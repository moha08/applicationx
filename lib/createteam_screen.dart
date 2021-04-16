import 'package:applicationx/beans/event.dart';
import 'package:applicationx/event_screen.dart';
import 'package:applicationx/teamhome_screen.dart';
import 'package:applicationx/viewevent_screen.dart';
import 'package:applicationx/viewteam_screen.dart';
import 'package:flutter/material.dart';

class Createteampage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("CREATE TEAM"),
        ),
        body: SafeArea(
            child: Center(
          child: CheckboxWidget(),
        )));
  }
}

class CheckboxWidget extends StatefulWidget {
  @override
  CheckboxWidgetState createState() => new CheckboxWidgetState();
}

class CheckboxWidgetState extends State {
  Map<String, bool> values = {
    'Player Name 1': false,
    'Player Name 2': false,
    'Player Name 3': false,
    'Player Name 4': false,
    'Player Name 5': false,
  };

  var tmpArray = [];

  getCheckboxItems() {
    values.forEach((key, value) {
      if (value == true) {
        tmpArray.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(tmpArray);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    tmpArray.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      RaisedButton(
        child: Text(
          "Number Of Selected Players: value/max size",
          style: TextStyle(fontSize: 18),
        ),
        onPressed: getCheckboxItems,
        color: Colors.pink,
        textColor: Colors.white,
        splashColor: Colors.grey,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      ),
      Expanded(
        child: ListView(
          children: values.keys.map((String key) {
            return new CheckboxListTile(
              title: new Text(key),
              value: values[key],
              activeColor: Colors.pink,
              checkColor: Colors.white,
              onChanged: (bool value) {
                setState(() {
                  values[key] = value;
                });
              },
            );
          }).toList(),
        ),
      ),
      RaisedButton(
        child: Text(
          "Submit",
          style: TextStyle(fontSize: 18),
        ),
        onPressed: getCheckboxItems,
        color: Colors.pink,
        textColor: Colors.white,
        splashColor: Colors.grey,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      ),
    ]);
  }
}
