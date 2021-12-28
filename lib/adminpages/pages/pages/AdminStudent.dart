import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progrem/empty/adminstudent.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminStudentsPage extends StatefulWidget {
  const AdminStudentsPage({Key? key}) : super(key: key);

  @override
  _AdminStudentsPageState createState() => _AdminStudentsPageState();
}

class _AdminStudentsPageState extends State<AdminStudentsPage> {
  var lists = [];
  TextEditingController username = TextEditingController();
  TextEditingController pwd1 = TextEditingController();
  TextEditingController name = TextEditingController();

  Future regStu(String username, String password, String name) async {
    Dio dio = new Dio();

    FormData formData = FormData.fromMap(
        {"username": username, "password": password, "sname": name});
    String url = "http://honghuos.cn/apis/registStu.php";
    //发起post请求
    Response response = await dio.post(url, data: formData);
    var textData = json.decode(response.toString());
    print(textData);
  }

  Future getNow() async {
    Dio dio = new Dio();

    FormData formData =
        FormData.fromMap({"type": "student", "token": "wxdqwe123Asdffghhjj"});
    String url = "http://honghuos.cn/apis/admin.php";
    //发起post请求
    Response response = await dio.post(url, data: formData);
    var textData = json.decode(response.toString());
    print(textData);
    AdminStudentsBean orderModel = AdminStudentsBean.fromJson(textData);
    var returnCode = orderModel.code;
    print(orderModel.data!.length);
    if (returnCode == 666) {
      setState(() {
        lists = orderModel.data!;
      });
    } else {}
  }

  @override
  void initState() {
    getNow();

    super.initState();
  }

  Widget getDefence(Data data) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "学号：${data.sid}",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "姓名：${data.sname}",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "导师：${data.steacher}",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title:  Text("学生管理"),
        
      ),
      floatingActionButton: TextButton(
          onPressed: () {
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(10)), //加圆角
                context: context,
                builder: (_) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(40, 20, 40, 0),
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          child: Text(
                            "添加用户",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(40, 5, 40, 5),
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          child: TextField(
                            controller: username,
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "学号",
                                labelStyle: TextStyle()),
                            maxLines: 1,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(40, 20, 40, 20),
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          child: TextField(
                            controller: pwd1,
                            textAlign: TextAlign.start,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "密码",
                                labelStyle: TextStyle()),
                            maxLines: 1,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(40, 20, 40, 20),
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          child: TextField(
                            controller: name,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "姓名",
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          child: TextButton(
                            onPressed: () {
                              regStu(username.value.text, pwd1.value.text,
                                  name.value.text);
                              Navigator.pop(context);
                              setState(() {
                                getNow();
                              });
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
          child: Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "添加用户",
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  Icons.add,
                  color: Colors.white,
                )
              ],
            ),
          )),
      body: ListView.builder(
          itemCount: lists.length,
          itemBuilder: (BuildContext, index) {
            return getDefence(lists[index]);
          }),
    );
  }
}
