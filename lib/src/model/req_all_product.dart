class ReqAllProduct {
  int? page;
  int? perPage;

  ReqAllProduct({this.page, this.perPage});

  ReqAllProduct.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['perPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['perPage'] = perPage;
    return data;
  }
}
