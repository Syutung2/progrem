

import 'package:flutter/material.dart';
import 'package:progrem/studentpages/pages/filemanager.dart';
import 'package:progrem/studentpages/pages/mainpages.dart';
import 'package:progrem/studentpages/pages/nowprogrem.dart';
import 'package:progrem/studentpages/pages/progrems.dart';

class TwoMainPage extends StatefulWidget {
  TwoMainPage({Key? key}) : super(key: key);
  @override
  _TwoMainPageState createState() => _TwoMainPageState();
}
class _TwoMainPageState extends State<TwoMainPage> {
  var list = [
    '当前项目',"所有项目","文件管理","个人中心"
  ];
  int currentIndex = 0;
  final items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('当前项目'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.view_list),
      title: Text("所有项目"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.file_upload),
      title: Text("文件管理"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people),
      title: Text("个人中心"),
    ),
  ];
  final bodyLists = [
    NowProgrems(),ProgremsPage(),FileManager(),StudentMinePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
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