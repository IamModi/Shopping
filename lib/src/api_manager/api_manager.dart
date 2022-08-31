import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shopping/src/model/req_all_product.dart';
import 'package:shopping/src/model/res_all_product.dart';

import 'api_service.dart';
import 'base_model.dart';

class ApiManager {
  static final ApiManager _instance = ApiManager._internal();

  factory ApiManager() {
    return _instance;
  }

  ApiManager._internal();

  Future<ResAllProduct> getProducts(
      BuildContext context, ReqAllProduct model) async {
    try {
      final response = await ApiService().post(
        context,
        "product_list.php",
        data: model.toJson(),
      );
      var newJson = json.decode(response.data);
      return ResAllProduct.fromJson(newJson);
    } on DioError catch (error) {
      throw BaseModel.fromJson(error.response?.data);
    }
  }
}
