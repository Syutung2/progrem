class AdminProgremBean {
  int? code;
  String? msg;
  List<Data>? data;

  AdminProgremBean({this.code, this.msg, this.data});

  AdminProgremBean.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
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
      {
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
