class StudentsBean {
  int? code;
  String? msg;
  List<Data>? data;

  StudentsBean({this.code, this.msg, this.data});

  StudentsBean.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data =[];
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
  String? s0;
  String? s1;
  String? sid;
  String? sname;

  Data({this.s0, this.s1, this.sid, this.sname});

  Data.fromJson(Map<String, dynamic> json) {
    s0 = json['0'];
    s1 = json['1'];
    sid = json['sid'];
    sname = json['sname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = this.s0;
    data['1'] = this.s1;
    data['sid'] = this.sid;
    data['sname'] = this.sname;
    return data;
  }
}
