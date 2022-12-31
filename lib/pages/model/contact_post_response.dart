class ContactPostResponse {
  bool? success;
  String? message;
  ContactRes? contactRes;

  ContactPostResponse({this.success, this.message, this.contactRes});

  ContactPostResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    contactRes =
        json['data'] != null ? new ContactRes.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.contactRes != null) {
      data['data'] = this.contactRes!.toJson();
    }
    return data;
  }
}

class ContactRes {
  int? registerId;
  String? name;
  String? mobile;
  String? nidBirth;
  String? address;
  String? union;
  String? image;
  String? nidImage;
  String? gender;
  String? status;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;

  ContactRes(
      {this.registerId,
      this.name,
      this.mobile,
      this.nidBirth,
      this.address,
      this.union,
      this.image,
      this.nidImage,
      this.gender,
      this.status,
      this.userId,
      this.updatedAt,
      this.createdAt,
      this.id});
  ContactRes.fromJson(Map<String, dynamic> json) {
    registerId = json['register_id'];
    name = json['name'];
    mobile = json['mobile'];
    nidBirth = json['nid_birth'];
    address = json['address'];
    union = json['union'];
    image = json['image'];
    nidImage = json['nid_image'];
    gender = json['gender'];
    status = json['status'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['register_id'] = this.registerId;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['nid_birth'] = this.nidBirth;
    data['address'] = this.address;
    data['union'] = this.union;
    data['image'] = this.image;
    data['nid_image'] = this.nidImage;
    data['gender'] = this.gender;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
