import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progrem/empty/file.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FileManager extends StatefulWidget {
  const FileManager({ Key? key }) : super(key: key);

  @override
  _FileManagerState createState() => _FileManagerState();
}

class _FileManagerState extends State<FileManager> {
 var lists = [];
  Future getNow()  async {
    Dio dio = new Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    FormData formData = FormData.fromMap(
     {
          "username":  sharedPreferences.getString("username"),
     });
    String url = "http://honghuos.cn/apis/getUrls.php";
    //发起post请求
    Response response = await dio.post(url, data: formData);
    var textData = json.decode(response.toString());
    print(textData);
    FileBean orderModel = FileBean.fromJson(textData);
    var returnCode = orderModel.code;
    print(orderModel.data!.length);
    if (returnCode==666) {
    setState(() {
           lists = orderModel.data!;
        });
    } else{

    }
  }

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
void fileUplod() async{
    ///创建Dio
    Dio dio = new Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map<String ,dynamic> map = Map();
    map["uid"]=sharedPreferences.getString("username");
   var  localImagePath  = await selectPic();
    map["file"] = await MultipartFile.fromFile(localImagePath!);
    ///通过FormData
    FormData formData = FormData.fromMap(map);
    ///发送post
    Response response = await dio.post("http://honghuos.cn/apis/addUrls.php", data: formData,
      ///这里是发送请求回调函数
      ///[progress] 当前的进度
      ///[total] 总进度
      onSendProgress: (int progress, int total) {
        print("当前进度是 $progress 总进度是 $total");
      },);
    ///服务器响应结果
    var data = response.data;
    getNow();
  }


  Future del(String path)  async {
    Dio dio = new Dio();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    FormData formData = FormData.fromMap(
     {
          "uid":  sharedPreferences.getString("username"),
          "upath": path,

     });
    String url = "http://honghuos.cn/apis/delUrls.php";
    //发起post请求
    Response response = await dio.post(url, data: formData);
    var textData = json.decode(response.toString());
    print(textData);
    FileBean orderModel = FileBean.fromJson(textData);
    var returnCode = orderModel.code;
    print(orderModel.data!.length);
    if (returnCode==666) {
    } else{

    }
  }
    @override
  void initState() {
    super.initState();
      setState(() {
              getNow();
            });
  }
  
Widget getUserInformation(Data data) {
  List p = data.upath!.split(".");
    int iii = p.length-1;

  String type = p[iii].toUpperCase();
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          child:  Column(
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
                            Container(
                              width: 80,
                              height: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.indigo,borderRadius: BorderRadius.all(Radius.circular(40))
                              ),
                              child: Text(
                            "${type}",

                            style: TextStyle(fontSize: 30,color: Colors.white),
                            maxLines: 1,
                            textAlign: TextAlign.left,
                          ),
                            ),
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            child: Text(
                            "${data.upath}",
                            style: TextStyle(fontSize: 10),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                      
                              TextButton(onPressed: (){
                                 Clipboard.setData(ClipboardData(text: "${data.upath}"));
                              }, child: Icon(Icons.copy)),
                               TextButton(onPressed: (){
                                 del(data.upath!);
                                getNow();

                            }, child: Icon(Icons.delete))
                            ],
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
    print(lists.length);
    return SingleChildScrollView(
      child: Column(
      children: [
         Container(
                       margin: EdgeInsets.all(10),
                                   width: double.infinity,
    height: 60,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child: FlatButton(
                    onPressed: () {
                        fileUplod();
                        
                    },
                    child: Text("文件上传",style: TextStyle(fontSize: 20,color: Colors.white),),),
               ),
         GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: lists.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //横轴元素个数
            crossAxisCount:  MediaQuery.of(context).size.width >
                          MediaQuery.of(context).size.height * 1 ? 4 : 2,
            //纵轴间距r
            mainAxisSpacing: 5.0,
            //横轴间距
            crossAxisSpacing: 10.0,
            //子组件宽高长度比例
            childAspectRatio: 0.5
            ),
      itemBuilder: (context,index){
      return Container(
          child:  getUserInformation(lists[index]),
        
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        );
      },
    )
      ],
    ),
    );
  }
}

