import 'package:applicationx/viewteam_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'backend/teams.dart';
import 'beans/team.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamlistPage extends StatefulWidget {
  @override
  _TeamlistPageState createState() => _TeamlistPageState();
}

class _TeamlistPageState extends State<TeamlistPage> {
  SlidableController slidableController;

  bool _isLoaded = false;

  List<Team> items = List<Team>();

  Future getTeamList() async {
    items = await Teams().getTeams();
    setState(() {
      _isLoaded = true;
    });
  }

  @protected
  void initState() {
    slidableController = SlidableController(
      onSlideAnimationChanged: handleSlideAnimationChanged,
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );
    print(_isLoaded);
    setState(() {
      getTeamList();
    });

    super.initState();
  }

  Animation<double> _rotationAnimation;
  Color _fabColor = Colors.pink;

  void handleSlideAnimationChanged(Animation<double> slideAnimation) {
    setState(() {
      _rotationAnimation = slideAnimation;
    });
  }

  void handleSlideIsOpenChanged(bool isOpen) {
    setState(() {
      _fabColor = isOpen ? Colors.green : Colors.pink;
    });
  }

  void myAlert1(String teamCode, String teamName) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text(
              'Send an Invitation By:',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      final Uri _emailLaunchUri = Uri(scheme: 'mailto',
                          //path: ,
                          queryParameters: {
                            'subject': 'Example Subject & Symbols are allowed!',
                            'body': '''Welcome to Sports Arte Application.
Join  A team: $teamName
Application link: 
Team Code: $teamCode
Thank you for using Sports Arte Application
Sports Arte Team'''
                          });
                      launch(_emailLaunchUri.toString());
                    },
                    child: Row(
                      children: <Widget>[
                        Image(
                          image: AssetImage("lib/images/Email.jpeg"),
                          height: 40,
                          width: 40,
                        ),
                        Text(
                          'Email',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: <Widget>[
                        FlatButton(
                          splashColor: Colors.white,
                          onPressed: () {
                            FlutterShareMe().shareToWhatsApp(
                                msg: '''Welcome to Sports Arte Application.
Join  A team: $teamName
Application link: 
Team Code: $teamCode
Thank you for using Sports Arte Application
Sports Arte Team''');
                          },
                          child: Image(
                            image: AssetImage("lib/images/WhatsApp.jpeg"),
                            height: 40,
                            width: 40,
                          ),
                        ),
                        Text(
                          'WhatsApp',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoaded == false) {
      EasyLoading.show(
        status: 'loading...',
      );
      return Container(
        child: null,
      );
    } else {
      EasyLoading.dismiss();
      return Scaffold(
        body: Center(
          child: OrientationBuilder(
            builder: (context, orientation) => _buildList(
                context,
                orientation == Orientation.portrait
                    ? Axis.vertical
                    : Axis.horizontal),
          ),
        ),
      );
    }
  }

  Widget _buildList(BuildContext context, Axis direction) {
    return ListView.builder(
      scrollDirection: direction,
      itemBuilder: (context, index) {
        final Axis slidableDirection =
            direction == Axis.horizontal ? Axis.vertical : Axis.horizontal;
        var item = items[index];
        return _getSlidableWithLists(context, index, slidableDirection);
      },
      itemCount: items.length,
    );
  }

  Widget _getSlidableWithLists(
      BuildContext context, int index, Axis direction) {
    final Team item = items[index];
    //final int t = index;
    return Slidable(
      key: Key(item.name),
      controller: slidableController,
      direction: direction,
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        onDismissed: (actionType) {
          _showSnackBar(
              context,
              actionType == SlideActionType.primary
                  ? 'Dismiss Archive'
                  : 'Dimiss Delete');
          setState(() {
            items.removeAt(index);
          });
        },
      ),
      actionPane: _getActionPane(index),
      actionExtentRatio: 0.25,
      child: direction == Axis.horizontal
          ? VerticalListItem(items[index])
          : HorizontalListItem(items[index]),
      actions: <Widget>[
        IconSlideAction(
            caption: 'View',
            color: Colors.pink,
            icon: Icons.view_list,
            onTap: () {
              print(item.docID);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewteamPage(
                          team: item,
                        )),
              );
            }),
      ],
      secondaryActions: (item.isAdmin == true)
          ? <Widget>[
              IconSlideAction(
                  caption: 'Assign Players',
                  color: Colors.green,
                  icon: Icons.assignment_ind,
                  onTap: () {
                    myAlert1(item.teamCode, item.name);
                  }),
              IconSlideAction(
                caption: 'Delete',
                color: Colors.pink,
                icon: Icons.delete,
                onTap: () => _showSnackBar(context, 'Delete'),
              ),
            ]
          : [],
    );
  }

  static Widget _getActionPane(int index) {
    switch (index % 4) {
      case 0:
        return SlidableBehindActionPane();
      case 1:
        return SlidableStrechActionPane();
      case 2:
        return SlidableScrollActionPane();
      case 3:
        return SlidableDrawerActionPane();
      default:
        return null;
    }
  }

  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: Colors.pink,
    ));
  }
}

class HorizontalListItem extends StatelessWidget {
  HorizontalListItem(this.item);
  final Team item;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 160.0,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: CircleAvatar(
              backgroundColor: Colors.red,
              child: Text('${item.name}'),
              foregroundColor: Colors.white,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                item.desc,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VerticalListItem extends StatelessWidget {
  VerticalListItem(this.item);
  final Team item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Slidable.of(context)?.renderingMode == SlidableRenderingMode.none
              ? Slidable.of(context)?.open()
              : Slidable.of(context)?.close(),
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(item.imageLink),
          ),
          title: Text(item.name),
          subtitle: Text(item.desc),
        ),
      ),
    );
  }
}
