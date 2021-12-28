import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progrem/adminpages/pages/pages/progrem.dart';
import 'package:progrem/empty/AdminProgremBean.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminProgremPage extends StatefulWidget {
  const AdminProgremPage({ Key? key }) : super(key: key);

  @override
  _AdminProgremPageState createState() => _AdminProgremPageState();
}

class _AdminProgremPageState extends State<AdminProgremPage> {
var lists = [];

  Future getNow() async {
    Dio dio = new Dio();

    FormData formData =
        FormData.fromMap({"type": "progrem", "token": "wxdqwe123Asdffghhjj"});
    String url = "http://honghuos.cn/apis/admin.php";
    //发起post请求
    Response response = await dio.post(url, data: formData);
    var textData = json.decode(response.toString());
    print(textData);
    AdminProgremBean orderModel = AdminProgremBean.fromJson(textData);
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
    Future saveString(String key,String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(
        key, value);
  }
  Widget getDefence(Data data) {
    return TextButton(
      onPressed: () { 
        saveString("pid", data.pid!);
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AdminProgrem()));

       },
    child: Card(
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
                  "编号：${data.pid}",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "名称：${data.pname}",
                  textAlign: TextAlign.left,
                  softWrap: true,
                  maxLines: 2,
                  
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "学生学号：${data.pStu}",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ],
        ),
      ),
    ),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title:  Text("教师管理"),
        
      ),
     
      body: ListView.builder(
          itemCount: lists.length,
          itemBuilder: (BuildContext, index) {
            return getDefence(lists[index]);
          }),
    );
  }
}