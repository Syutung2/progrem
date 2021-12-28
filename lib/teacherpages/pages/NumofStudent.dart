import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progrem/empty/login.dart';
import 'package:progrem/empty/now.dart';
import 'package:progrem/empty/now2.dart';
import 'package:progrem/empty/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DefencesStudentPage extends StatefulWidget {
  const DefencesStudentPage({Key? key}) : super(key: key);

  @override
  _DefencesStudentPageState createState() => _DefencesStudentPageState();
}

class _DefencesStudentPageState extends State<DefencesStudentPage> {
  String _chosenValue = 'Google';
  var students = [];
  String? pid;
  String? pname;
  String? pStu;
  String? ps;
  int pState = 0;
  String? pNumbyTeacher;
  String? pNum;
  String? pCommit;
  double num = 0.0;
  String? purl;
  String? last;
  var user;
  var states = ["立项", "前期", "中期", "后期", "答辩", "完结"];
  TextEditingController sid = TextEditingController();
  TextEditingController nums = TextEditingController();
  TextEditingController commit = TextEditingController();

  Future updateCommit(String nums, String commit) async {
    Dio dio = new Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    FormData formData = FormData.fromMap({
      "tea": pState,
      "pro": pid,
      "num": nums,
      "com": commit,
    });
    String url = "http://honghuos.cn/apis/defence.php";

    //发起post请求
    Response response = await dio.post(url, data: formData);
    var textData = json.decode(response.toString());
    StudentsBean orderModel = StudentsBean.fromJson(textData);
    var returnCode = orderModel.code;
    print(textData);
    if (returnCode == 666) {
    } else {}
  }

  Future getLast() async {
    Dio dio = new Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    FormData formData = FormData.fromMap({"pro": pid, "state": pState});
    String url = "http://honghuos.cn/apis/getnum.php";

    //发起post请求
    Response response = await dio.post(url, data: formData);

    print(response.toString());
    setState(() {
      last = response.toString();
    });

    print("last:$last");
  }

  Future getNow() async {
    Dio dio = new Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    FormData formData = FormData.fromMap({
      "teacher": sharedPreferences.get("username"),
    });
    String url = "http://honghuos.cn/apis/getStudents.php";

    //发起post请求
    Response response = await dio.post(url, data: formData);
    var textData = json.decode(response.toString());
    StudentsBean orderModel = StudentsBean.fromJson(textData);
    var returnCode = orderModel.code;
    print(textData);
    if (returnCode == 666) {
      setState(() {
        for (var item in orderModel.data!) {
          students.add(item.sid);
        }
        _chosenValue = students[0];
      });
    } else {}
  }

  Future updateStudent(String uid) async {
    Dio dio = new Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    FormData formData = FormData.fromMap({
      "sid": uid,
      "tid": sharedPreferences.get("username"),
    });
    String url = "http://honghuos.cn/apis/adminTutor.php";

    //发起post请求
    Response response = await dio.post(url, data: formData);
    var textData = json.decode(response.toString());
    StudentsBean orderModel = StudentsBean.fromJson(textData);
    var returnCode = orderModel.code;
    print(textData);
    if (returnCode == 666) {
    } else {}
  }

  Future getNow2() async {
    Dio dio = new Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    FormData formData = FormData.fromMap({
      "username": _chosenValue,
    });
    String url = "http://honghuos.cn/apis/getProgrem.php";
    //发起post请求
    Response response = await dio.post(url, data: formData);
    var textData = json.decode(response.toString());
    NowBean orderModel = NowBean.fromJson(textData);
    var returnCode = orderModel.code;
    print(textData);

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
        purl = orderModel.data!.url;
        print(orderModel.data!.url);
        num = pState / 5;
      });
    } else {}
  }

  void initState() {
    Future.wait([
      // 2秒后返回结果
      Future.delayed(new Duration(milliseconds: 200), () {
        return getNow();
      }),
      // 4秒后返回结果
      Future.delayed(new Duration(milliseconds: 500), () {
        return getNow2();
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

  Widget getUserInformation() {
    if (last == null || last == "") {
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
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
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                              maxLines: 6,
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "下载文件",
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.start,
                          ),
                          TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                10)), //加圆角
                                    context: context,
                                    builder: (_) {
                                      return SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Center(
                                              child: Text(
                                                "点击确认后，到浏览器打开\n $purl",
                                                style: TextStyle(fontSize: 24),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  40, 0, 40, 20),
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 5, 10, 5),
                                              height: 60,
                                              decoration: BoxDecoration(
                                                  color: Colors.indigo,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              30.0))),
                                              child: TextButton(
                                                onPressed: () {
                                                  Clipboard.setData(ClipboardData(
                                                      text:
                                                          "http://honghuos.cn/apis/upload/${purl}"));
                                                  Navigator.pop(context);
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "确定",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Colors.indigo,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Icons.file_download,
                                  color: Colors.white,
                                ),
                              ))
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "评分",
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.start,
                          ),
                          TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                10)), //加圆角
                                    context: context,
                                    builder: (_) {
                                      return SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  40, 20, 40, 20),
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 5, 10, 5),
                                              height: 60,
                                              decoration: BoxDecoration(
                                                  color: Colors.lightBlueAccent,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              30.0))),
                                              child: TextField(
                                                controller: nums,
                                                textAlign: TextAlign.start,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "评分",
                                                    labelStyle: TextStyle()),
                                                maxLines: 1,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  40, 0, 40, 20),
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 5, 10, 5),
                                              height: 250,
                                              decoration: BoxDecoration(
                                                  color: Colors.lightBlueAccent,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              30.0))),
                                              child: TextField(
                                                controller: commit,
                                                textAlign: TextAlign.start,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "评分",
                                                    labelStyle: TextStyle()),
                                                maxLines: 8,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  40, 0, 40, 20),
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 5, 10, 5),
                                              height: 60,
                                              decoration: BoxDecoration(
                                                  color: Colors.indigo,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              30.0))),
                                              child: TextButton(
                                                onPressed: () {
                                                  updateCommit(nums.value.text,
                                                      commit.value.text);
                                                  Navigator.pop(context);
                                                  getNow2();
                                                  getLast();
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "评分",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Colors.indigo,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Icons.confirmation_number,
                                  color: Colors.white,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    } else {
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
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
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                              maxLines: 6,
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "下载文件",
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.start,
                          ),
                          TextButton(
                              onPressed: () {
                                print("dfgfg");
                                showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                10)), //加圆角
                                    context: context,
                                    builder: (_) {
                                      return SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Center(
                                              child: Text(
                                                "点击确认后，到浏览器打开\n $purl",
                                                style: TextStyle(fontSize: 24),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  40, 0, 40, 20),
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 5, 10, 5),
                                              height: 60,
                                              decoration: BoxDecoration(
                                                  color: Colors.indigo,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              30.0))),
                                              child: TextButton(
                                                onPressed: () {
                                                  Clipboard.setData(ClipboardData(
                                                      text:
                                                          "http://honghuos.cn/apis/upload/${purl}"));
                                                  Navigator.pop(context);
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "确定",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: Colors.indigo,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  Icons.file_download,
                                  color: Colors.white,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        title: Center(
          child: DropdownButton<String>(
            hint: Text(_chosenValue),
            underline: Container(height: 0),
            value: _chosenValue,
            items: students.map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _chosenValue = value!;
              });
              getNow2();
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 60,
              margin: EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.indigoAccent,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: FlatButton(
                onPressed: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadiusDirectional.circular(10)), //加圆角
                      context: context,
                      builder: (_) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(40, 20, 40, 20),
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30.0))),
                                child: TextField(
                                  controller: sid,
                                  textAlign: TextAlign.start,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "学生ID",
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
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30.0))),
                                child: TextButton(
                                  onPressed: () {
                                    updateStudent(sid.value.text);
                                    Navigator.pop(context);
                                    getNow();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "添加",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Text(
                  "添加学生",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            getUserInformation()
          ],
        ),
      ),
    );
  }
}
