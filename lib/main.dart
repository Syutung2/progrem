import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progrem/adminpages/adminMainPage.dart';
import 'package:progrem/studentpages/studentMain.dart';
import 'package:progrem/teacherpages/teacherMainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginpage/studentpage.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle style = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String islogin = "false";

  Future getString() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String s =sharedPreferences.getString("islogin")!;
    setState(() {
      islogin = s;
    });
  }

  @override
  void initState() {
    super.initState();
    getString();

  }

  @override
  Widget build(BuildContext context) {

    if (islogin == "student") {
      return MaterialApp(
        title: '项目管理APP',
        theme: ThemeData(primarySwatch: Colors.blue, cardColor: Colors.white),
        darkTheme:
            ThemeData.dark(),
        home: TwoMainPage(),
      );
    } else if (islogin == "teacher") {
      return MaterialApp(
        title: '项目管理APP',
        theme: ThemeData(primarySwatch: Colors.blue, cardColor: Colors.white),
        darkTheme:
            ThemeData.dark(),
        home: TeacherPage(),
      );
    }
     else if (islogin == "admin") {
      return MaterialApp(
        title: '项目管理APP',
        theme: ThemeData(primarySwatch: Colors.blue, cardColor: Colors.white),
        darkTheme:
            ThemeData.dark(),
        home: AdminHome(),
      );
    }
    else {
      return MaterialApp(
        title: '项目管理APP',
        theme: ThemeData(primarySwatch: Colors.blue, cardColor: Colors.white54),
        darkTheme:
            ThemeData.dark(),
        home: StudentLoginPage(),
      );
    }
  }
}
