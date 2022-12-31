class ContactResponse {
  int? currentPage;
  List<Contact>? contact;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  ContactResponse(
      {this.currentPage,
      this.contact,
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

  ContactResponse.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      contact = <Contact>[];
      json['data'].forEach((v) {
        contact!.add(new Contact.fromJson(v));
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
    if (this.contact != null) {
      data['data'] = this.contact!.map((v) => v.toJson()).toList();
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

class Contact {
  int? id;
  String? registerId;
  String? name;
  String? mobile;
  String? nidBirth;
  String? union;
  String? address;
  String? image;
  String? gender;
  String? nidImage;
  String? status;
  String? userId;
  String? createdAt;
  String? updatedAt;

  Contact(
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

  Contact.fromJson(Map<String, dynamic> json) {
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
