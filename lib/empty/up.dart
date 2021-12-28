class UpdateBean {
  int? code;
  String? msg;
  String? urlname;

  UpdateBean({this.code, this.msg, this.urlname});

  UpdateBean.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    urlname = json['urlname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['urlname'] = this.urlname;
    return data;
  }
}