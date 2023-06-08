class previewDonationRes {
  bool? success;
  String? message;
  Data? data;

  previewDonationRes({this.success, this.message, this.data});

  previewDonationRes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? contactId;
  String? itemName;
  String? description;
  String? donationDate;
  String? quantity;
  int? userId;
  String? amount;
  String? image;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.contactId,
      this.itemName,
      this.description,
      this.donationDate,
      this.quantity,
      this.userId,
      this.amount,
      this.image,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    contactId = json['contact_id'];
    itemName = json['item_name'];
    description = json['description'];
    donationDate = json['donation_date'];
    quantity = json['quantity'];
    userId = json['user_id'];
    amount = json['amount'];
    image = json['image'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contact_id'] = this.contactId;
    data['item_name'] = this.itemName;
    data['description'] = this.description;
    data['donation_date'] = this.donationDate;
    data['quantity'] = this.quantity;
    data['user_id'] = this.userId;
    data['amount'] = this.amount;
    data['image'] = this.image;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
