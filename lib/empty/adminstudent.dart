class AdminStudentsBean {
  int? code;
  String? msg;
  List<Data>? data;

  AdminStudentsBean({this.code, this.msg, this.data});

  AdminStudentsBean.fromJson(Map<String, dynamic> json) {
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

  String? sid;
  String? spw;
  String? sname;
  String? steacher;

  Data(
      {
      this.sid,
      this.spw,
      this.sname,
      this.steacher});

  Data.fromJson(Map<String, dynamic> json) {
    sid = json['sid'];
    spw = json['spw'];
    sname = json['sname'];
    steacher = json['steacher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sid'] = this.sid;
    data['spw'] = this.spw;
    data['sname'] = this.sname;
    data['steacher'] = this.steacher;
    return data;
  }
}