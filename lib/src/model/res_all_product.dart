class ResAllProduct {
  int? status;
  String? message;
  int? totalRecord;
  int? totalPage;
  List<ProductDetails>? data;

  ResAllProduct(
      {this.status, this.message, this.totalRecord, this.totalPage, this.data});

  ResAllProduct.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalRecord = json['totalRecord'];
    totalPage = json['totalPage'];
    if (json['data'] != null) {
      data = <ProductDetails>[];
      json['data'].forEach((v) {
        data!.add(ProductDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['totalRecord'] = totalRecord;
    data['totalPage'] = totalPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductDetails {
  int? id;
  String? slug;
  String? title;
  String? description;
  int? price;
  String? featured_image;
  String? status;
  String? created_at;

  ProductDetails(
      {this.id,
      this.slug,
      this.title,
      this.description,
      this.price,
      this.featured_image,
      this.status,
      this.created_at});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    featured_image = json['featured_image'];
    status = json['status'];
    created_at = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['featured_image'] = featured_image;
    data['status'] = status;
    data['created_at'] = created_at;
    return data;
  }
}
