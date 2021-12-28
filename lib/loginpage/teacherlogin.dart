import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progrem/demopage/demo.dart';
import 'package:progrem/empty/login.dart';
import 'package:progrem/loginpage/adminlogin.dart';
import 'package:progrem/loginpage/studentpage.dart';
import 'package:progrem/teacherpages/pages/mainpages.dart';
import 'package:progrem/teacherpages/teacherMainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherLoginPage extends StatefulWidget {
  TeacherLoginPage({Key? key}) : super(key: key);
  @override
  _TeacherLoginPageState createState() => _TeacherLoginPageState();
}

class _TeacherLoginPageState extends State<TeacherLoginPage> {
    var num = 0;

  Future teaLogin(String username, String password) async {
    Dio dio = new Dio();
    FormData formData = FormData.fromMap(
        {"username": username, "password": password, "type": "teacher"});
    String url = "http://honghuos.cn/apis/login.php";
    //发起post请求
    Response response = await dio.post(url, data: formData);
    print(response.toString());
    var textData = json.decode(response.toString());
    TeacherBean orderModel = TeacherBean.fromJson(textData);
    var returnCode = orderModel.code;
    Teacher teacher = orderModel.data!;
    if (returnCode == 666) {
      saveString("islogin", "teacher");
      saveString("username", teacher.tid!);
      saveString("name", teacher.tname!);
      saveString("zhichen", teacher.tpro!);
         Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => TeacherPage()));
    } else {}
  }

  Future saveString(String key, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController NameController = TextEditingController();
    TextEditingController PasswordController = TextEditingController();
    var isTeacher = "学生版";
    var versionnow = "teacher";
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(20, 150, 20, 150),
          child: TextButton(onPressed: (){
           if (num<10) {
              num++;
              print(num);
            } else {
              num=0;
                                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              DemoCountPage()));
            }
          }, child: Image.network(
            "https://flutter.cn/asset/flutter-hero-laptop2.png",
            width: 200,
          )),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(40, 0, 40, 20),
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          height: 60,
          decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          child: TextField(
            controller: NameController,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "请输入你的账号",
                labelStyle: TextStyle()),
            maxLines: 1,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(40, 0, 40, 20),
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          height: 60,
          decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          child: TextField(
            controller: PasswordController,
            textAlign: TextAlign.center,
            obscureText: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "请输入你的密码",
                labelStyle: TextStyle()),
            maxLines: 1,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(40, 0, 40, 20),
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          height: 60,
          decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          child: TextButton(
            onPressed: () {
              print(NameController.value.text);
              print(PasswordController.value.text);
              teaLogin(
                  NameController.value.text, PasswordController.value.text);
           
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "登录",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )
              ],
            ),
          ),
        ),
        Center(
            child: Column(
          children: [
            Text(
              "当前版本：$versionnow \n version: AlphaTest 1.0.1",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              StudentLoginPage()));
                },
                child: Text(
                  "切换$isTeacher",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => AdminLoginPage()));
                },
                child: Text(
                  "切换管理员版",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                )),
          ],
        )),
      ]),
    ));
  }
}
