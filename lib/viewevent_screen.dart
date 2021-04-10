import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'beans/event.dart';
import 'backend/events.dart';

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
        floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.person),
            label: Text(
              "Assign Coach",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            onPressed: () {
              myAlert1();
            }),
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
                                      'Select Coach - Team A',
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
                                      'Select Coach - Team B',
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
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
      height: 700,
      child: DataTable(
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
          DataColumn(
              label: Icon(
            Icons.delete,
            color: Colors.green,
            size: 28,
          )),
          // ),
        ],
        rows: const <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Ravi')),
              DataCell(Text('Defender')),
              DataCell(
                IconButton(
                  onPressed: null,
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  icon: Icon(Icons.delete),
                  tooltip: 'Delete',
                  //  onPressed: () {
                  //   setState(() {
                ),
              ),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Mohammed')),
              DataCell(Text('Midfielder')),
              DataCell(
                IconButton(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  onPressed: null,
                  icon: Icon(Icons.delete),
                  tooltip: 'Delete',
                  //  onPressed: () {
                  //   setState(() {
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
