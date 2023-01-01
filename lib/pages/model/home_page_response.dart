class HomeData {
  bool? success;
  int? donates;
  int? contacts;

  HomeData({this.success, this.donates, this.contacts});

  HomeData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    donates = json['donates'];
    contacts = json['contacts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['donates'] = this.donates;
    data['contacts'] = this.contacts;
    return data;
  }
}
