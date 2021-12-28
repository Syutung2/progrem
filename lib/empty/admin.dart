class Adminbean {
  int? code;
  String? msg;
  Data? data;

  Adminbean({this.code, this.msg, this.data});

  Adminbean.fromJson(Map<String, dynamic> json) {
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
  String? aid;

  Data({this.aid});

  Data.fromJson(Map<String, dynamic> json) {
    aid = json['aid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aid'] = this.aid;
    return data;
  }
}
