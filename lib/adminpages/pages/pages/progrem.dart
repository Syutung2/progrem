import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progrem/empty/de.dart';
import 'package:progrem/empty/login.dart';
import 'package:progrem/empty/now.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminProgrem extends StatefulWidget {
  const AdminProgrem({Key? key}) : super(key: key);

  @override
  _AdminProgremState createState() => _AdminProgremState();
}

class Defence {
  final String dtea;
  final String dstu;
  final int num;
  final String comment;

  Defence(this.dtea, this.dstu, this.num, this.comment);
}

class _AdminProgremState extends State<AdminProgrem> {
  String? pid;
  String? pname;
  String? pStu;
  String? ps;
  int pState = 0;
  String? pNumbyTeacher;
  String? pNum;
  String? pCommit;
  String? purl;
  double num = 0.0;
  var user;
  var states = ["立项", "前期", "中期", "后期", "答辩", "完结"];
  // ignore: deprecated_member_use
  var defence = [];
  Future getNow() async {
    Dio dio = new Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    FormData formData = FormData.fromMap({
      "pid": sharedPreferences.get("pid"),
    });
    String url = "http://honghuos.cn/apis/adminprogrem.php";

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
        purl = orderModel.data!.url;

        num = pState / 5;
      });
    } else {}
  }

  Future Makedefences() async {
    Dio dio = new Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    FormData formData = FormData.fromMap({
      "username": pStu,
      "pid": pid,
    });
    String url = "http://honghuos.cn/apis/makedefence.php";
    //发起post请求
    Response response = await dio.post(url, data: formData);
    var textData = json.decode(response.toString());
    print(textData);
  }

  Future getNow2() async {
    Dio dio = new Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    FormData formData = FormData.fromMap({
      "type": "admin",
      "pid": sharedPreferences.get("pid"),
    });
    String url = "http://honghuos.cn/apis/getDefence.php";
    //发起post请求
    Response response = await dio.post(url, data: formData);
    var textData = json.decode(response.toString());
    print(textData);
    DefenceBean orderModel = DefenceBean.fromJson(textData);
    print(orderModel.data!);

    setState(() {
      defence = orderModel.data!;
    });
  }

  @override
  void initState() {
    Future.wait([
      // 2秒后返回结果
      Future.delayed(new Duration(milliseconds: 500), () {
        return getNow();
      }),
      // 4秒后返回结果
      Future.delayed(new Duration(seconds: 1), () {
        return getNow2();
      })
    ]).then((results) {
      print(results[0] + results[1]);
    }).catchError((e) {
      print(e);
    });

    super.initState();
  }

  Widget getUserInformation() {
    print(defence.length);
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
        appBar: AppBar(
          title: Center(
            child: Text(pname!),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              getUserInformation(),
              Center(
                  child: Column(
                children: [
                  Center(
                    child: Text(
                      "各阶段打分情况",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: pState,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          //横轴元素个数
                          crossAxisCount: MediaQuery.of(context).size.width >
                                  MediaQuery.of(context).size.height * 1
                              ? 4
                              : 2,
                          //纵轴间距r
                          mainAxisSpacing: 1.0,
                          //横轴间距
                          crossAxisSpacing: 6.0,
                          //子组件宽高长度比例
                          childAspectRatio: 1),
                      itemBuilder: (context, index) {
                        return Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                "阶段：${states[index]}",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                "打分：${defence[index].dNum}",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                "评价：${defence[index].dCommit}",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 15),
                                maxLines: 6,
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              )),
              Center(
                child: Text(
                  "总分:$pNum",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.lightBlue,
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
                                Center(
                                  child: Text(
                                    "点击确认后，到浏览器打开\n $purl",
                                    style: TextStyle(fontSize: 24),
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
                                          textAlign: TextAlign.center,
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
                  child: Text(
                    "附件下载",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
