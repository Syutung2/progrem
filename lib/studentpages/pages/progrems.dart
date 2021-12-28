import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:progrem/empty/now2.dart';
import 'package:progrem/empty/up.dart';
import 'package:progrem/studentpages/globenum.dart';
import 'package:progrem/studentpages/pages/progrem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgremsPage extends StatefulWidget {
  const ProgremsPage({Key? key}) : super(key: key);

  @override
  _ProgremsPageState createState() => _ProgremsPageState();
}

class _ProgremsPageState extends State<ProgremsPage> {
  var states = ["立项", "前期", "中期", "后期", "答辩", "完结"];
  var lists;
  String? urlname;

  Future shenbao(String name, String ps) async {
    Dio dio = new Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    FormData formData = FormData.fromMap({
      "student": sharedPreferences.getString("username"),
      "name": name,
      "ps": ps,
      "url": urlname
    });
    String url = "http://honghuos.cn/apis/applyProgrem.php";
    //发起post请求
    Response response = await dio.post(url, data: formData);
    var textData = json.decode(response.toString());
    print(textData);
    ProgremsBean orderModel = ProgremsBean.fromJson(textData);
    var returnCode = orderModel.code;
    print(orderModel.data!.length);
    getNow();
  }

  Future del(String name) async {
    Dio dio = new Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    FormData formData = FormData.fromMap({
      "pid": name,
    });
    String url = "http://honghuos.cn/apis/delProgrem.php";
    //发起post请求
    Response response = await dio.post(url, data: formData);
    var textData = json.decode(response.toString());
    print(textData);
    ProgremsBean orderModel = ProgremsBean.fromJson(textData);
    var returnCode = orderModel.code;
    print(orderModel.data!.length);
    getNow();
  }

  Future getNow() async {
    Dio dio = new Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    FormData formData = FormData.fromMap({
      "username": sharedPreferences.getString("username"),
    });
    String url = "http://honghuos.cn/apis/getProgrems.php";
    //发起post请求
    Response response = await dio.post(url, data: formData);
    var textData = json.decode(response.toString());
    print(textData);
    ProgremsBean orderModel = ProgremsBean.fromJson(textData);
    var returnCode = orderModel.code;
    print(orderModel.data!.length);
    if (returnCode == 666) {
      setState(() {
        lists = orderModel.data;
      });
    } else {}
  }

  @override
  void initState() {
    super.initState();
    getNow();
  }

  Future<String?> selectPic() async {
//    FilePickerResult result = await FilePicker.platform.pickFiles(); //单选

    FilePickerResult result = (await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['docx', 'pdf', 'doc', "txt", "jpg"],
    ))!;
    if (result != null) {
      PlatformFile file = result.files.first;
      print('name:' + file.name);
      print(file.bytes);
      return file.path;
    } else {
      //user cancled the picker
      print('用户停止了选择图片');
      return null;
    }
  }

  void fileUplod() async {
    ///创建Dio
    Dio dio = new Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map<String, dynamic> map = Map();
    map["uid"] = sharedPreferences.getString("username");
    var localImagePath = await selectPic();
    map["file"] = await MultipartFile.fromFile(localImagePath!);

    ///通过FormData
    FormData formData = FormData.fromMap(map);

    ///发送post
    Response response = await dio.post(
      "http://honghuos.cn/apis/addUrls.php", data: formData,

      ///这里是发送请求回调函数
      ///[progress] 当前的进度
      ///[total] 总进度
      onSendProgress: (int progress, int total) {
        print("当前进度是 $progress 总进度是 $total");
      },
    );

    ///服务器响应结果
    var data = response.data;
    var textData = json.decode(response.toString());
    UpdateBean orderModel = UpdateBean.fromJson(textData);

    print(textData);
    var returnCode = orderModel.code;
    if (returnCode == 666) {
      setState(() {
        urlname = orderModel.urlname;
      });
    }
  }

  Future saveString(String key, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }

  Widget getUserInformation(Data data) {
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
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "项目编号:${data.pid}\n${data.pname}",
                          style: TextStyle(fontSize: 20),
                          maxLines: 3,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlatButton(
                            onPressed: () {
                              saveString("pid", data.pid!);
                              Numbers.data1 = data;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Progrem()));
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
                                Icons.arrow_right_alt_rounded,
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

  TextEditingController name = TextEditingController();
  TextEditingController ps = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(lists.length);
    if (lists.length != 0) {
return SingleChildScrollView(
      child: Column(
        children: [
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
                                    hintText: "项目名称",
                                    labelStyle: TextStyle()),
                                maxLines: 1,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(40, 0, 40, 20),
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              height: 250,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlueAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0))),
                              child: TextField(
                                controller: ps,
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "项目介绍",
                                    labelStyle: TextStyle()),
                                maxLines: 8,
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(40, 20, 40, 20),
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30.0))),
                                child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        fileUplod();
                                      });
                                    },
                                    child: Text((urlname == null
                                        ? "选择文件"
                                        : urlname)!))),
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
                                  shenbao(name.value.text, ps.value.text);
                                  Navigator.pop(context);
                                  getNow();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "申报",
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
                "项目申报",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: lists.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //横轴元素个数
                crossAxisCount: MediaQuery.of(context).size.width >
                        MediaQuery.of(context).size.height * 1
                    ? 2
                    : 1,
                //纵轴间距r
                mainAxisSpacing: 5.0,
                //横轴间距
                crossAxisSpacing: 10.0,
                //子组件宽高长度比例
                childAspectRatio: 2),
            itemBuilder: (context, index) {
              return Container(
                child: getUserInformation(lists[index]),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
              );
            },
          )
        ],
      ),
    );    } else {
    return SingleChildScrollView(
      child: Column(
        children: [
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
                                    hintText: "项目名称",
                                    labelStyle: TextStyle()),
                                maxLines: 1,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(40, 0, 40, 20),
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              height: 250,
                              decoration: BoxDecoration(
                                  color: Colors.lightBlueAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0))),
                              child: TextField(
                                controller: ps,
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "项目介绍",
                                    labelStyle: TextStyle()),
                                maxLines: 8,
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.fromLTRB(40, 20, 40, 20),
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.lightBlueAccent,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30.0))),
                                child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        fileUplod();
                                      });
                                    },
                                    child: Text((urlname == null
                                        ? "选择文件"
                                        : urlname)!))),
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
                                  shenbao(name.value.text, ps.value.text);
                                  Navigator.pop(context);
                                  getNow();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "申报",
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
                "项目申报",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
         
        ],
      ),
    );
    }
    
  }
}
