import 'package:applicationx/viewteam_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'item.dart';

class TeamlistPage extends StatefulWidget {
  @override
  _TeamlistPageState createState() => _TeamlistPageState();
}

class _TeamlistPageState extends State<TeamlistPage> {
  SlidableController slidableController;

  final List<Item> items = List.generate(
    6,
    (i) => Item(
      i,
      'Team Name $i',
      'No. of Players $i',
      Colors.pink,
    ),
  );

  @protected
  void initState() {
    slidableController = SlidableController(
      onSlideAnimationChanged: handleSlideAnimationChanged,
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );
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

  void myAlert1() {
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
                    onPressed: () {
                      Navigator.pop(context);
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
                        Image(
                          image: AssetImage("lib/images/WhatsApp.jpeg"),
                          height: 40,
                          width: 40,
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
    final Item item = items[index];
    //final int t = index;
    return Slidable(
      key: Key(item.title),
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
      actionPane: _getActionPane(item.index),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewteamPage()),
              );
            }),

        //_showSnackBar(context, 'View')

        IconSlideAction(
          caption: 'Edit',
          color: Colors.green,
          icon: Icons.edit,
          onTap: () => _showSnackBar(context, 'Edit'),
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
            caption: 'Assign Players',
            color: Colors.green,
            icon: Icons.assignment_ind,
            onTap: () {
              myAlert1();
            }),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.pink,
          icon: Icons.delete,
          onTap: () => _showSnackBar(context, 'Delete'),
        ),
      ],
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
  final Item item;
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
              backgroundColor: item.color,
              child: Text('${item.index}'),
              foregroundColor: Colors.white,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                item.subtitle,
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
  final Item item;

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
            backgroundColor: item.color,
            child: Text('${item.index}'),
            foregroundColor: Colors.white,
          ),
          title: Text(item.title),
          subtitle: Text(item.subtitle),
        ),
      ),
    );
  }
}
