import 'package:flutter/material.dart';

class Count{
  final String id;
  final String password;

  Count(this.id, this.password);
}
class DemoCountPage extends StatelessWidget {
    var studentdemocounrs = [
        Count("20190101", "wxdqwe123"),
        Count("20190111", "wxdqwe123"),
        Count("2019011133", "wxdqwe123")
    ];
        var pteacherdemocounrs = [
        Count("20190000", "wxdqwe123"),
        Count("2019002", "wxdqwe123"),
        Count("2019003", "wxdqwe123"),
                Count("2019004", "wxdqwe123"),
        Count("2019005", "wxdqwe123"),
                Count("2019006", "wxdqwe123"),
        Count("2019007", "wxdqwe123"),
                Count("2019022", "wxdqwe123"),
    ];
            var admindemocounrs = [
        Count("admin", "wxdqwe123"),
    ];
   DemoCountPage({ Key? key }) : super(key: key);
  Widget getCountView(Count count){
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(count.id),
          Text(count.password)
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
              Container(
                margin: EdgeInsets.fromLTRB(15, 50, 14, 0),
                alignment: Alignment.centerLeft,
                child: Text("学生测试账号"),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  return getCountView(studentdemocounrs[index]);
              },itemCount: studentdemocounrs.length,),
               Container(
                margin: EdgeInsets.fromLTRB(15, 15, 14, 0),
                alignment: Alignment.centerLeft,
                                child: Text("教师测试账号"),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  return getCountView(pteacherdemocounrs[index]);
              },itemCount: pteacherdemocounrs.length,),
               Container(
                margin: EdgeInsets.fromLTRB(15, 15, 14, 0),
                alignment: Alignment.centerLeft,
                                child: Text("管理员测试账号"),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  return getCountView(admindemocounrs[index]);
              },itemCount: admindemocounrs.length,)
          ],
        ),
      ),
    );
  }
}