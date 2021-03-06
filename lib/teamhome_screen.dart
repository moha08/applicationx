import 'package:flutter/material.dart';
import 'package:applicationx/event_screen.dart';
import 'package:applicationx/team_screen.dart';
import 'package:applicationx/dashboard_screen.dart';
import 'package:applicationx/setting_screen.dart';
import 'package:applicationx/profile_screen.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';

class TeamHomePage extends StatefulWidget {
  TeamHomePage({Key key}) : super(key: key);

  @override
  TeamHomePageState createState() => TeamHomePageState();
}

class TeamHomePageState extends State<TeamHomePage> {
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: selectedPage(selectedIndex),
      ),
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.green,
          selectedItemBorderColor: Colors.white,
          unselectedItemIconColor: Colors.white,
          unselectedItemLabelColor: Colors.white,
          selectedItemBackgroundColor: Colors.pink,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.pink,
        ),
        selectedIndex: selectedIndex,
        onSelectTab: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          FFNavigationBarItem(
            iconData: Icons.event,
            label: 'Events',
          ),
          FFNavigationBarItem(
            iconData: Icons.people,
            label: 'Teams',
          ),
          FFNavigationBarItem(
            iconData: Icons.dashboard,
            label: 'Dashboard',
          ),
          FFNavigationBarItem(
            iconData: Icons.settings,
            label: 'Settings',
          ),
          FFNavigationBarItem(
            iconData: Icons.person,
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

Widget selectedPage(int index) {
  if (index == 0) {
    return EventPage();
  } else if (index == 1) {
    return TeamPage();
  } else if (index == 2) {
    return DashboardPage();
  } else if (index == 3) {
    return SettingPage();
  } else
    return ProfilePage();
}
