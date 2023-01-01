class DonationDetailsRes {
  int? totalDonate;
  List<Donation> data = [];

  DonationDetailsRes({this.totalDonate, required this.data});

  DonationDetailsRes.fromJson(Map<String, dynamic> json) {
    totalDonate = json['total_donate'];
    if (json['data'] != null) {
      data = <Donation>[];
      json['data'].forEach((v) {
        data.add(new Donation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_donate'] = this.totalDonate;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Donation {
  int? id;
  String? contactId;
  String? itemName;
  String? description;
  List<String>? image;
  String? donationDate;
  String? quantity;
  String? amount;
  String? userId;
  String? createdAt;
  String? updatedAt;

  Donation(
      {this.id,
      this.contactId,
      this.itemName,
      this.description,
      this.image,
      this.donationDate,
      this.quantity,
      this.amount,
      this.userId,
      this.createdAt,
      this.updatedAt});

  Donation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contactId = json['contact_id'];
    itemName = json['item_name'];
    description = json['description'];
    image = json['image'].cast<String>();
    donationDate = json['donation_date'];
    quantity = json['quantity'];
    amount = json['amount'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['contact_id'] = this.contactId;
    data['item_name'] = this.itemName;
    data['description'] = this.description;
    data['image'] = this.image;
    data['donation_date'] = this.donationDate;
    data['quantity'] = this.quantity;
    data['amount'] = this.amount;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
