class NowBean {
  int? code;
  String? msg;
  Data? data;

  NowBean({this.code, this.msg, this.data});

  NowBean.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
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
  String? pNumbyTeacher;
  String? pNum;
  String? pCommit;
  String? url;

  Data(
      {this.pid,
      this.pname,
      this.pStu,
      this.ps,
      this.pState,
      this.pNumbyTeacher,
      this.pNum,
      this.pCommit,
      this.url});

  Data.fromJson(Map<String, dynamic> json) {
    pid = json['pid'];
    pname = json['pname'];
    pStu = json['pStu'];
        url = json['pUrl'];

    ps = json['ps'];
    pState = json['pState'];
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
    data['pNumbyTeacher'] = this.pNumbyTeacher;
    data['pNum'] = this.pNum;
    data['pCommit'] = this.pCommit;
    data['url'] = this.url;
    return data;
  }
}
