class BaseModel {
  String? message;
  String? code;
  String? error;

  BaseModel({this.message});

  BaseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['code'] = code;
    data['error'] = error;
    return data;
  }
}
