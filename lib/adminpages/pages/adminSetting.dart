import 'package:flutter/material.dart';
import 'package:progrem/adminpages/pages/pages/AdminProgrem.dart';
import 'package:progrem/adminpages/pages/pages/AdminStudent.dart';
import 'package:progrem/adminpages/pages/pages/AdminTeacher.dart';

class AdminSettingsPage extends StatefulWidget {
  const AdminSettingsPage({ Key? key }) : super(key: key);

  @override
  _AdminSettingsPageState createState() => _AdminSettingsPageState();
}

class _AdminSettingsPageState extends State<AdminSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
         Container(
          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          height: 60,
          decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AdminStudentsPage()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "学生管理",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          height: 60,
          decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          child: TextButton(
            onPressed: () {
                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AdminTeacherPage()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "教师管理",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )
              ],
            ),
          ),
        ),
            Container(
          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          height: 60,
          decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          child: TextButton(
            onPressed: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AdminProgremPage()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "项目管理",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ],),
    );
  }
}