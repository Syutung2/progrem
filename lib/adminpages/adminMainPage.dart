

import 'package:flutter/material.dart';
import 'package:progrem/adminpages/pages/adminMinePage.dart';
import 'package:progrem/adminpages/pages/adminSetting.dart';

class AdminHome extends StatefulWidget {
  AdminHome({Key? key}) : super(key: key);
  @override
  _AdminHomeState createState() => _AdminHomeState();
}
class _AdminHomeState extends State<AdminHome> {
  var list = [
    '系统管理',"个人中心"
  ];
  int currentIndex = 0;
  final items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      title: Text('系统管理'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people),
      title: Text("个人中心"),
    ),
  ];
  final bodyLists = [
    AdminSettingsPage(),AdminMinePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
                shadowColor: Colors.transparent,

        title: Container(
          alignment: Alignment.center,
          child: Text(list[currentIndex]),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: currentIndex,
        onTap: onTap,
        unselectedItemColor: Colors.blueGrey,
        selectedItemColor: Colors.lightBlue,
        type: BottomNavigationBarType.fixed,
      ),
      body: bodyLists[currentIndex],
    );
  }

  void onTap(int value) {
    setState(() {
      currentIndex = value;
    });
  }
}