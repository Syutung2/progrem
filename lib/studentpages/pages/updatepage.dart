import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progrem/empty/now.dart';
import 'package:progrem/empty/up.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProgremPage extends StatefulWidget {
  String? pid;
  int state;
  UpdateProgremPage({Key? key, required this.pid, required this.state})
      : super(key: key);
  @override
  _UpdateProgremPageState createState() =>
      _UpdateProgremPageState(pid: this.pid, state: this.state);
}

class _UpdateProgremPageState extends State<UpdateProgremPage> {
  String path = "选择文件";
  String? pid;
  int state;
  _UpdateProgremPageState({required this.pid, required this.state});
  Future<String?> selectPic() async {
//    FilePickerResult result = await FilePicker.platform.pickFiles(); //单选

    FilePickerResult result = (await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
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
        path = orderModel.urlname!;
      });
      Fluttertoast.showToast(
          msg: "上传成功",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "上传失败，检查是不是重复上传了",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future upInfor(int id) async {
    Dio dio = new Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    FormData formData = FormData.fromMap({
      "pState": id,
      "pUrl": path,
      "pid": pid,
    });
    String url = "http://honghuos.cn/apis/updateInformation.php";
    //发起post请求
    Response response = await dio.post(url, data: formData);
    var textData = json.decode(response.toString());
    NowBean orderModel = NowBean.fromJson(textData);
    var returnCode = orderModel.code;
    if (returnCode == 666) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
           Container(
                margin: EdgeInsets.fromLTRB(40, 40, 40, 40),
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                height: 60,
                width: double.infinity,
             
                child: Text("更新进度",style: TextStyle(fontSize:30),)
                ),
            Container(
                margin: EdgeInsets.fromLTRB(40, 20, 40, 20),
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                child: TextButton(onPressed: () {
                  fileUplod();
                }, child: StatefulBuilder(
                  builder: (BuildContext context,
                      void Function(void Function()) setState) {
                    return Text(path);
                  },
                ))),
            Container(
              margin: EdgeInsets.fromLTRB(40, 0, 40, 20),
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              child: TextButton(
                onPressed: () {
                  upInfor(state);
                        Fluttertoast.showToast(
          msg: "请返回上一个页面",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
                 Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "更新",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
