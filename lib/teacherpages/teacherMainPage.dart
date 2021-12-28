

import 'package:flutter/material.dart';
import 'package:progrem/studentpages/pages/filemanager.dart';
import 'package:progrem/studentpages/pages/mainpages.dart';
import 'package:progrem/studentpages/pages/nowprogrem.dart';
import 'package:progrem/studentpages/pages/progrems.dart';
import 'package:progrem/teacherpages/pages/NumofStudent.dart';
import 'package:progrem/teacherpages/pages/mainpages.dart';

class TeacherPage extends StatefulWidget {
  TeacherPage({Key? key}) : super(key: key);
  @override
  _TeacherPageState createState() => _TeacherPageState();
}
class _TeacherPageState extends State<TeacherPage> {
  var list = [
    '答辩打分',"学生打分","个人中心"
  ];
  int currentIndex = 0;
  final items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.view_list),
      title: Text("学生打分"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people),
      title: Text("个人中心"),
    ),
  ];
  final bodyLists = [
    DefencesStudentPage(),TeacherMinePage()
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