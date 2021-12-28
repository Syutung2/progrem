import 'package:flutter/material.dart';
import 'package:progrem/commun/privacyPage.dart';
import 'package:progrem/loginpage/studentpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentMinePage extends StatefulWidget {
  const StudentMinePage({Key? key}) : super(key: key);

  @override
  _StudentMinePageState createState() => _StudentMinePageState();
}

class _StudentMinePageState extends State<StudentMinePage> {
  var name, username, teacher;
  Future getString() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      username = sharedPreferences.getString("username");
      name = sharedPreferences.getString("name");
      teacher = sharedPreferences.getString("teacher");
    });
  }

  Future saveString(String key, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getString();
    });
  }

  Widget getUserInformation() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      padding: EdgeInsets.all(2),
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(15),
                      child: Text(
                        name,
                        style: TextStyle(color: Colors.white, fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                      decoration: new BoxDecoration(
                          color: Colors.indigo,
                          borderRadius:
                              BorderRadius.all(Radius.circular(75.0))),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "用户名：$username",
                            style: TextStyle(fontSize: 30),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            teacher == null ? "你还没有选定导师" : "导师:$teacher",
                            style: TextStyle(fontSize: 30),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlatButton(
                                onPressed: () {
                                  showLicensePage(
                                      context: context,
                                      applicationIcon: Image.asset(
                                        "https://flutter.cn/asset/flutter-hero-laptop2.png",
                                        width: 200,
                                        height: 200,
                                      ),
                                      applicationName: "智慧项目管理app",
                                      applicationVersion: "v1.0.0",
                                      applicationLegalese: "智慧项目管理app");
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.menu_open_sharp,
                                      color: Colors.greenAccent,
                                    ),
                                    Text("开源许可")
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlatButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              PrivacyPage()));
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.privacy_tip,
                                      color: Colors.greenAccent,
                                    ),
                                    Text("隐私协议")
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
              color: Colors.indigoAccent,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: FlatButton(
            onPressed: () {
              saveString("islogin", "");
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => StudentLoginPage()));
            },
            child: Text(
              "退出登录",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        )
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
