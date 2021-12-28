class DefenceBean {
  int? code;
  String? msg;
  List<Data>? data;

  DefenceBean({this.code, this.msg, this.data});

  DefenceBean.fromJson(Map<String, dynamic> json) {
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
  String? dtea;
  String? dstu;
  String? dPro;
  String? dNum;
  String? dCommit;

  Data(
      {
      this.dtea,
      this.dstu,
      this.dPro,
      this.dNum,
      this.dCommit});

  Data.fromJson(Map<String, dynamic> json) {
    dtea = json['dtea'];
    dstu = json['dstu'];
    dPro = json['dPro'];
    dNum = json['dNum'];
    dCommit = json['dCommit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dtea'] = this.dtea;
    data['dstu'] = this.dstu;
    data['dPro'] = this.dPro;
    data['dNum'] = this.dNum;
    data['dCommit'] = this.dCommit;
    return data;
  }
}

