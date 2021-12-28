import 'dart:convert';

class ProgremsBean {
  int? code;
  String? msg;
  List? data;

  ProgremsBean({this.code, this.msg, this.data});

  ProgremsBean.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = [];
      for (var item in json['data']) {
        data!.add(Data.fromJson(item));

      }
   
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? s0;
  String? s1;
  String? s2;
  String? s3;
  String? s4;
  String? n5;
  String? n6;
  String? n7;
  String? n8;
  String? pid;
  String? pname;
  String? pStu;
  String? ps;
  String? pState;
  String? pUrl;
  String? pNumbyTeacher;
  String? pNum;
  String? pCommit;

  Data(
      {this.s0,
      this.s1,
      this.s2,
      this.s3,
      this.s4,
      this.n5,
      this.n6,
      this.n7,
      this.n8,
      this.pid,
      this.pname,
      this.pStu,
      this.ps,
      this.pState,
      this.pUrl,
      this.pNumbyTeacher,
      this.pNum,
      this.pCommit});

  Data.fromJson(Map<String, dynamic> json) {
    s0 = json['0'];
    s1 = json['1'];
    s2 = json['2'];
    s3 = json['3'];
    s4 = json['4'];
    n5 = json['5'];
    n6 = json['6'];
    n7 = json['7'];
    n8 = json['8'];
    pid = json['pid'];
    pname = json['pname'];
    pStu = json['pStu'];
    ps = json['ps'];
    pState = json['pState'];
    pUrl = json['pUrl'];
    pNumbyTeacher = json['pNumbyTeacher'];
    pNum = json['pNum'];
    pCommit = json['pCommit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = this.s0;
    data['1'] = this.s1;
    data['2'] = this.s2;
    data['3'] = this.s3;
    data['4'] = this.s4;
    data['5'] = this.n5;
    data['6'] = this.n6;
    data['7'] = this.n7;
    data['8'] = this.n8;
    data['pid'] = this.pid;
    data['pname'] = this.pname;
    data['pStu'] = this.pStu;
    data['ps'] = this.ps;
    data['pState'] = this.pState;
    data['pUrl'] = this.pUrl;
    data['pNumbyTeacher'] = this.pNumbyTeacher;
    data['pNum'] = this.pNum;
    data['pCommit'] = this.pCommit;
    return data;
  }
}
