import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progrem/empty/login.dart';
import 'package:progrem/empty/now.dart';
import 'package:progrem/empty/now2.dart';
import 'package:progrem/empty/up.dart';
import 'package:progrem/studentpages/globenum.dart';
import 'package:progrem/studentpages/pages/progrem.dart';
import 'package:progrem/studentpages/pages/updatepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NowProgrems extends StatefulWidget {
  const NowProgrems({Key? key}) : super(key: key);

  @override
  _NowProgremsState createState() => _NowProgremsState();
}

class _NowProgremsState extends State<NowProgrems> {
  String? pid;
  String? pname;
  String? pStu;
  String? ps;
  int pState = 0;
  String? pNumbyTeacher;
  String? pNum;
  String? pCommit;
  double num = 0.0;
  String? urlname;
  String? last;
  var user;
  var states = ["立项", "前期", "中期", "后期", "答辩", "完结"];
  String path = "上传文件";
  Future saveString(String key, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }

  Future getLast() async {
    Dio dio = new Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    FormData formData = FormData.fromMap({"pro": pid, "state": pState});
    String url = "http://honghuos.cn/apis/getnum.php";

    //发起post请求
    Response response = await dio.post(url, data: formData);
    var textData = response.toString();
    print(textData);
    print(pState);
    if (pState == 5 || textData != null || textData != "") {
      setState(() {
        last = "null";
      });
    } else {
      setState(() {
        last = textData;
      });
    }
  }


  Future getNow() async {
    Dio dio = new Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    FormData formData = FormData.fromMap({
      "username": sharedPreferences.getString("username"),
    });
    String url = "http://honghuos.cn/apis/getProgrem.php";
    //发起post请求
    Response response = await dio.post(url, data: formData);
    var textData = json.decode(response.toString());
    NowBean orderModel = NowBean.fromJson(textData);
    var returnCode = orderModel.code;
    if (returnCode == 666) {
      setState(() {
        pid = orderModel.data!.pid;
        pname = orderModel.data!.pname;
        pStu = orderModel.data!.pStu;
        ps = orderModel.data!.ps;
        pState = int.parse(orderModel.data!.pState!);
        pNumbyTeacher = orderModel.data!.pNumbyTeacher;
        pNum = orderModel.data!.pNum;
        pCommit = orderModel.data!.pCommit;
        num = pState / 5;
      });
    } else {}
  }

   @override
  reassemble(){
      Future.wait([
      // 2秒后返回结果
      Future.delayed(new Duration(milliseconds: 200), () {
        return getNow();
      }),
      Future.delayed(new Duration(milliseconds: 600), () {
        return getLast();
      })
    ]).then((results) {
      print("OK");
    }).catchError((e) {
      print(e);
    });
    super.reassemble();
    
  }
  @override
  void initState() {
    Future.wait([
      // 2秒后返回结果
      Future.delayed(new Duration(milliseconds: 200), () {
        return getNow();
      }),
      Future.delayed(new Duration(milliseconds: 600), () {
        return getLast();
      })
    ]).then((results) {
      print("OK");
    }).catchError((e) {
      print(e);
    });
    super.initState();
  }

  TextEditingController name = TextEditingController();
  TextEditingController ppp = TextEditingController();
  Widget getUpdate() {
    if (last == "null") {
      return Container();
    } else {
      return Container(
        margin: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "更新进展",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.start,
            ),
            TextButton(
                onPressed: () {
                  int news = pState + 1;
                  print(news);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              UpdateProgremPage(
                                pid:pid,state : news
                              )));
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    Icons.update,
                    color: Colors.white,
                  ),
                ))
          ],
        ),
      );
    }
  }

  Widget getUserInformation() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 20,
                      margin: EdgeInsets.fromLTRB(10, 40, 10, 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: ClipRRect(
                        // 边界半径（`borderRadius`）属性，圆角的边界半径。
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        child: LinearProgressIndicator(
                          value: num,
                          backgroundColor: Colors.grey,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "立项\n开干",
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "前期\n加油",
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "中期\n加油",
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "后期\n加油",
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "答辩\n快胜利了",
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "完结\n撒花",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "项目编号:$pid",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          "$pname",
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.start,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Text(
                            "简介：$ps",
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                            maxLines: 6,
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  getUpdate(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          getUserInformation(),
        ],
      ),
    ));
  }
}
