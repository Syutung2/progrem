class AdminTeacherBean {
  int? code;
  String? msg;
  List<Data>? data;

  AdminTeacherBean({this.code, this.msg, this.data});

  AdminTeacherBean.fromJson(Map<String, dynamic> json) {
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
      data['data'] = this.data
      !.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? tid;
  String? tpw;
  String? tname;
  String? tpro;

  Data(
      {
      this.tid,
      this.tpw,
      this.tname,
      this.tpro});

  Data.fromJson(Map<String, dynamic> json) {
    tid = json['tid'];
    tpw = json['tpw'];
    tname = json['tname'];
    tpro = json['tpro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['tid'] = this.tid;
    data['tpw'] = this.tpw;
    data['tname'] = this.tname;
    data['tpro'] = this.tpro;
    return data;
  }
}
