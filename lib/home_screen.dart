import 'package:flutter/material.dart';

//class HomePage extends StatefulWidget {
// @override
// State<StatefulWidget> createState() => new _State();
//}

//class _State extends State<HomePage> {
//@override
//Widget build(BuildContext context) {
//return Scaffold(
//  appBar: AppBar(
//title: Text('Home Page'),
//));
//}
//}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final widgetOptions = [
    Text('Beer List'),
    Text('Add new beer'),
    Text('Favourites'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Flutter BottomNavigationBar Example'),
          backgroundColor: Colors.green),
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.local_drink),
              title: Text('Beers'),
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_a_photo),
              title: Text('New Beer'),
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text('Favourites'),
              backgroundColor: Colors.green),
        ],
        currentIndex: selectedIndex,
        fixedColor: Colors.green,
        onTap: onItemTapped,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
