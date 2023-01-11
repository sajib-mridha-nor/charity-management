class UnionModel {
  bool? success;
  List<Union>? data;

  UnionModel({this.success, this.data});

  UnionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Union>[];
      json['data'].forEach((v) {
        data!.add(new Union.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Union {
  int? id;
  String? enName;
  String? bnName;
  String? createdAt;
  String? updatedAt;

  Union({this.id, this.enName, this.bnName, this.createdAt, this.updatedAt});

  Union.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enName = json['en_name'];
    bnName = json['bn_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['en_name'] = this.enName;
    data['bn_name'] = this.bnName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
