class DonationHistoryRes {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  DonationHistoryRes(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  DonationHistoryRes.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  int? id;
  String? contactId;
  String? itemName;
  String? description;
  String? donationDate;
  String? quantity;
  String? amount;
  String? userId;
  String? createdAt;
  String? updatedAt;
  Contacts? contacts;

  Data(
      {this.id,
      this.contactId,
      this.itemName,
      this.description,
      this.donationDate,
      this.quantity,
      this.amount,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.contacts});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contactId = json['contact_id'];
    itemName = json['item_name'];
    description = json['description'];
    donationDate = json['donation_date'];
    quantity = json['quantity'];
    amount = json['amount'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    contacts = json['contacts'] != null
        ? new Contacts.fromJson(json['contacts'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['contact_id'] = this.contactId;
    data['item_name'] = this.itemName;
    data['description'] = this.description;
    data['donation_date'] = this.donationDate;
    data['quantity'] = this.quantity;
    data['amount'] = this.amount;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.contacts != null) {
      data['contacts'] = this.contacts!.toJson();
    }
    return data;
  }
}

class Contacts {
  int? id;
  String? registerId;
  String? name;
  String? mobile;
  String? nidBirth;
  String? union;
  String? address;
  Null? image;
  String? gender;
  String? nidImage;
  String? status;
  String? userId;
  String? createdAt;
  String? updatedAt;

  Contacts(
      {this.id,
      this.registerId,
      this.name,
      this.mobile,
      this.nidBirth,
      this.union,
      this.address,
      this.image,
      this.gender,
      this.nidImage,
      this.status,
      this.userId,
      this.createdAt,
      this.updatedAt});

  Contacts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    registerId = json['register_id'];
    name = json['name'];
    mobile = json['mobile'];
    nidBirth = json['nid_birth'];
    union = json['union'];
    address = json['address'];
    image = json['image'];
    gender = json['gender'];
    nidImage = json['nid_image'];
    status = json['status'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['register_id'] = this.registerId;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['nid_birth'] = this.nidBirth;
    data['union'] = this.union;
    data['address'] = this.address;
    data['image'] = this.image;
    data['gender'] = this.gender;
    data['nid_image'] = this.nidImage;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
