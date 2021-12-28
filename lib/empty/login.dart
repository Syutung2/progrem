

class StudentBean {
  int? code;
  String? msg;
  Student? data;

  StudentBean({this.code, this.msg, this.data});

  StudentBean.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Student.fromJson(json['data']) : null!;
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

class Student {
  String? sid;
  String? sname;
  String? steacher;

  Student({this.sid, this.sname, this.steacher});

  Student.fromJson(Map<String, dynamic> json) {
    sid = json['sid'];
    sname = json['sname'];
    steacher = json['steacher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sid'] = this.sid;
    data['sname'] = this.sname;
    data['steacher'] = this.steacher;
    return data;
  }
}

class TeacherBean {
  int? code;
  String? msg;
  Teacher? data;

  TeacherBean({this.code, this.msg, this.data});

  TeacherBean.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Teacher.fromJson(json['data']) : null;
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

class Teacher {
  String? tid;
  String? tname;
  String? tpro;

  Teacher({this.tid, this.tname, this.tpro});

  Teacher.fromJson(Map<String, dynamic> json) {
    tid = json['tid'];
    tname = json['tname'];
    tpro = json['tpro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tid'] = this.tid;
    data['tname'] = this.tname;
    data['tpro'] = this.tpro;
    return data;
  }
}