import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final widgetOptions = [
    Text('Events List'),
    Text('Team List'),
    Text('Chats'),
    Text('Settings'),
    Text('Profile')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Events'), backgroundColor: Colors.green),
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 36,
        showUnselectedLabels: true,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.event),
              title: Text('Events'),
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.group),
              title: Text('Teams'),
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              title: Text('Chats'),
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_page),
              title: Text('Profile'),
              backgroundColor: Colors.green),
        ],
        currentIndex: selectedIndex,
        fixedColor: Colors.pink,
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
