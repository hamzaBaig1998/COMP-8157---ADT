import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:w_class/screens/scan_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'ProfilePage.dart';
import 'add_friend_tab.dart';
import 'home_tab.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  List<Widget> _listPages = [
    LeaderBoard(),
    ScanTab(),
    AddFriendScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.qr_code_2, size: 30),
            Icon(Icons.person_add, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.green,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
        body: _listPages[_page]);
  }
}