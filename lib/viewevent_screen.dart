import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VieweventPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<VieweventPage> {
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
            Center(child: TeamData()),
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
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            'Event Name:',
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
            'Team Size:',
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
            'Team Name:',
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
            'Event Date & Time:',
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
            'Event Location:',
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
