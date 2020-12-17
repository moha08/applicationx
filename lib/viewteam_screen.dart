import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'beans/team.dart';

class ViewteamPage extends StatefulWidget {
  Team team;
  ViewteamPage({this.team});
  @override
  State<StatefulWidget> createState() => new _State(team: team);
}

class _State extends State<ViewteamPage> {
  Team team;
  _State({this.team});
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
                text: "Information",
              ),
              Tab(icon: Icon(Icons.contacts), text: "Players"),
            ],
          ),
          title: Text('View Team'),
        ),
        body: TabBarView(
          children: [
            Center(
              child: TeamData(
                teamName: team.name,
                imageLink: team.imageLink,
                teamType: team.type == 2 ? "Company" : "Friends",
              ),
            ),
            Center(child: PlayerData()),
          ],
        ),
      ),
    );
  }
}

class TeamData extends StatelessWidget {
  String teamName;
  String imageLink;
  String teamType;
  TeamData({
    this.teamName,
    this.imageLink,
    this.teamType,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: ListView(children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: Text(
            'Team Information',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
          child: Image(
            image: NetworkImage(imageLink),
            width: 150,
            height: 150,
          ),
        ),
        Container(
          padding: EdgeInsets.all(30),
          child: Row(
            children: [
              Text(
                'Team Name: ',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                teamName,
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(30),
          child: Row(
            children: [
              Text(
                'Team Type: ',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                teamType,
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(30),
          child: Row(
            children: [
              Text(
                'Number of Players:',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                10.toString(),
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
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
