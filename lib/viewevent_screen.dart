import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'addteam_screen.dart';
import 'beans/event.dart';
import 'backend/events.dart';
import 'createteam_screen.dart';
import 'join_team.dart';
import 'metadata/images_path_enum.dart';

class VieweventPage extends StatefulWidget {
  final String eventName;
  VieweventPage(this.eventName);
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<VieweventPage> {
  @override
  void initState() {
    super.initState();
    print("Event Name is " + widget.eventName);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Colors.pink,
            labelColor: Colors.pink,
            unselectedLabelColor: Colors.white,
            indicatorWeight: 5,
            tabs: [
              Tab(
                icon: Icon(Icons.perm_device_information),
                text: "DETAILS",
              ),
              Tab(icon: Icon(Icons.reduce_capacity), text: "LINE UP"),
            ],
          ),
          title: Text('VIEW EVENT'),
        ),
        body: TabBarView(
          children: [
            Center(child: TeamData(widget.eventName)),
            Center(child: PlayerData()),
          ],
        ),
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
                child: Icon(Icons.assignment_ind),
                backgroundColor: Colors.green,
                label: 'Assign Coach',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {
                  myAlert1();
                }),
            SpeedDialChild(
                child: Icon(Icons.group_add),
                backgroundColor: Colors.pink,
                label: 'Create Team',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Createteampage()),
                  );
                }),
          ],
        ),
      ),
    );
  }

  void myAlert1() {
    {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            var _value = 1;
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              title: Text(
                'Assign Coach:',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              content: Container(
                height: MediaQuery.of(context).size.height / 4,
                child: Column(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                dropdownColor: Colors.green[50],
                                // elevation: 8,
                                isExpanded: true,
                                value: _value,
                                items: [
                                  DropdownMenuItem(
                                    child: Text(
                                      'Select Coach - White Team',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[700]),
                                      //  fontWeight: FontWeight.bold),
                                      // textAlign: TextAlign.center,
                                    ),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      'Mohammed',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[700]),
                                    ),
                                    value: 2,
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      'Ali',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[700]),
                                    ),
                                    value: 3,
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _value = value;
                                  });
                                }),
                          ),
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      padding: EdgeInsets.all(15),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                dropdownColor: Colors.green[50],
                                // elevation: 8,
                                isExpanded: true,
                                value: _value,
                                items: [
                                  DropdownMenuItem(
                                    child: Text(
                                      'Select Coach - Color Team',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[700]),
                                      //  fontWeight: FontWeight.bold),
                                      // textAlign: TextAlign.center,
                                    ),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      'Mohammed',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[700]),
                                    ),
                                    value: 2,
                                  ),
                                  DropdownMenuItem(
                                    child: Text(
                                      'Ali',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[700]),
                                    ),
                                    value: 3,
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _value = value;
                                  });
                                }),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: FlatButton(
                        color: Colors.green,
                        child: Text(
                          'Ok',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }
  }
}

createteam_screen() {}

class TeamData extends StatelessWidget {
  String eventName;
  TeamData(this.eventName);

  Future<Event> getDataForEvent() async {
    Event event = Event();
    event = await Events().getEventsByName(eventName);
    return event;
  }

  Widget getFutureContainerForEvent() {
    List teamSize = [
      'No Size',
      '5 VS 5',
      '6 VS 6',
      '7 VS 7',
      '8 VS 8',
      '9 VS 9',
      '10 VS 10',
      '11 VS 11'
    ];
    return FutureBuilder<Event>(
        future: getDataForEvent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            // return: show loading widget

            print(snapshot.data.toString());
          }
          if (snapshot.hasError) {
            // return: show error widget
          }

          return Container(
            padding: EdgeInsets.all(10),
            child: ListView(children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Event Name: ' + snapshot.data.name,
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Team Size: ' + teamSize[snapshot.data.teamSize],
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Team Name: ' + snapshot.data.teamName,
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Event Date & Time: ' +
                      snapshot.data.fullDateTime.replaceAll("00:00:00.000", ""),
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Event Location: ' + snapshot.data.locationName,
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                height: 700,
                child: DataTable(
                  sortAscending: true,
                  showBottomBorder: true,
                  showCheckboxColumn: true,
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text('Player Name',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          )),
                    ),
                    DataColumn(
                      label: Text(
                        'Role',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Line Up',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    // ),
                  ],
                  rows: const <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Ravi')),
                        DataCell(Text('Defender')),
                        DataCell(Text('Yes')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Mohammed')),
                        DataCell(Text('Midfielder')),
                        DataCell(Text('No')),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return getFutureContainerForEvent();
  }
}

class PlayerData extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
        // MaterialApp(
        //  home: Scaffold(

        Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RaisedButton.icon(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            onPressed: () {
              myAlert1(context);
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            label: Text(
              'White Team - Coach Name',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            icon: Icon(
              Icons.person,
              color: Colors.white,
              size: 30,
            ),
            textColor: Colors.white,
            splashColor: Colors.red,
            color: Colors.green,
          ),
          Image(image: AssetImage(ImagesPathEnum.LINEUP_IMG)),
          RaisedButton.icon(
            padding: EdgeInsets.fromLTRB(10, 4, 4, 4),
            onPressed: () {
              myAlert1(context);
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            label: Text(
              'Color Team - Coach Name',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            icon: Icon(
              Icons.person,
              color: Colors.white,
              size: 30,
            ),
            textColor: Colors.white,
            splashColor: Colors.red,
            color: Colors.pink,
          ),
        ],
      ),
    );
    //),
    // ),
    //);
  }
}

void myAlert1(BuildContext context) {
  {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          var _value = 1;
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            content: Container(
              child: DataTable(
                horizontalMargin: 15,
                sortAscending: true,
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text('Player Name',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                  ),
                  DataColumn(
                    label: Text(
                      'Role',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  // ),
                ],
                rows: const <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Ravi')),
                      DataCell(Text('Defender')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Ravi')),
                      DataCell(Text('Defender')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Ravi')),
                      DataCell(Text('Defender')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Ravi')),
                      DataCell(Text('Defender')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Ravi')),
                      DataCell(Text('Defender')),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  DataTable alert = DataTable(
    horizontalMargin: 40,
    sortAscending: true,
    columns: const <DataColumn>[
      DataColumn(
          label: Icon(
        Icons.person,
        color: Colors.green,
        size: 28,
      )),
      DataColumn(
        label: Text('Player Name',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )),
      ),
      DataColumn(
        label: Text(
          'Role',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      // ),
    ],
    rows: const <DataRow>[
      DataRow(
        cells: <DataCell>[
          DataCell(
            IconButton(
              onPressed: null,
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              icon: Icon(Icons.person),
              tooltip: 'Player',
              //  onPressed: () {
              //   setState(() {
            ),
          ),
          DataCell(Text('Ravi')),
          DataCell(Text('Defender')),
        ],
      ),
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class Playerlist extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DataTable(
      horizontalMargin: 40,
      sortAscending: true,
      columns: const <DataColumn>[
        DataColumn(
            label: Icon(
          Icons.person,
          color: Colors.green,
          size: 28,
        )),
        DataColumn(
          label: Text('Player Name',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
        ),
        DataColumn(
          label: Text(
            'Role',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        // ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(
              IconButton(
                onPressed: null,
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                icon: Icon(Icons.person),
                tooltip: 'Player',
                //  onPressed: () {
                //   setState(() {
              ),
            ),
            DataCell(Text('Ravi')),
            DataCell(Text('Defender')),
          ],
        ),
      ],
    );
  }
}
