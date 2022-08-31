import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'base_model.dart';

class ApiService {
  Dio _dio = Dio();
  String tag = "API call :";
  CancelToken? _cancelToken;
  static final Dio mDio = Dio();

  static final ApiService _instance = ApiService._internal();

  factory ApiService({bool stripeAuth = false}) {
    mDio.options.headers['Authorization'] =
        "Bearer eyJhdWQiOiI1IiwianRpIjoiMDg4MmFiYjlmNGU1MjIyY2MyNjc4Y2FiYTQwOGY2MjU4Yzk5YTllN2ZkYzI0NWQ4NDMxMTQ4ZWMz";
    mDio.options.headers['Accept-Version'] = "v1";
    mDio.options.headers['Accept-Language'] = "en";
    return _instance;
  }

  ApiService._internal() {
    _dio = initApiServiceDio();
  }

  Dio initApiServiceDio() {
    _cancelToken = CancelToken();
    final baseOption = BaseOptions(
      connectTimeout: 120 * 1000,
      receiveTimeout: 120 * 1000,
      baseUrl: "http://205.134.254.135/~mobile/MtProject/public/api/",
      contentType: 'application/json',
      headers: {
        'Authorization':
            "Bearer eyJhdWQiOiI1IiwianRpIjoiMDg4MmFiYjlmNGU1MjIyY2MyNjc4Y2FiYTQwOGY2MjU4Yzk5YTllN2ZkYzI0NWQ4NDMxMTQ4ZWMz",
        'Accept-Version': "v1",
        'Accept-Language': "en",
      },
    );
    mDio.options = baseOption;
    final mInterceptorsWrapper = InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint("$tag headers ${options.headers.toString()}",
            wrapWidth: 1024);
        debugPrint("$tag ${options.baseUrl.toString() + options.path}",
            wrapWidth: 1024);
        debugPrint("$tag queryParameters ${options.queryParameters.toString()}",
            wrapWidth: 1024);
        debugPrint("$tag ${options.data.toString()}", wrapWidth: 1024);
        return handler.next(options);
      },
      onResponse: (e, handler) {
        debugPrint("Code  ${e.statusCode.toString()}", wrapWidth: 1024);
        debugPrint("Response ${e.toString()}", wrapWidth: 1024);
        return handler.next(e);
      },
      onError: (e, handler) {
        debugPrint("$tag ${e.error.toString()}", wrapWidth: 1024);
        debugPrint("$tag ${e.response.toString()}", wrapWidth: 1024);
        return handler.next(e);
      },
    );
    mDio.interceptors.add(mInterceptorsWrapper);
    return mDio;
  }

  void cancelRequests({CancelToken? cancelToken}) {
    cancelToken == null
        ? _cancelToken!.cancel('Cancelled')
        : cancelToken.cancel();
  }

  Future<Response> get(
    BuildContext context,
    String endUrl, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final isConnected = await checkInternet();
      if (!isConnected) {
        return Future.error(BaseModel(message: "Internet not connected"));
      }
      return await (_dio.get(
        endUrl,
        queryParameters: params,
        cancelToken: cancelToken ?? _cancelToken,
        options: options,
      )).catchError((e) {
        // if (!checkSessionExpire(e, context)) {
        //   throw e;
        // }
      });
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        return Future.error(BaseModel(message: "Poor internet connection"));
      }
      rethrow;
    }
  }

  Future<Response> post(
    BuildContext context,
    String endUrl, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final isConnected = await checkInternet();
      if (!isConnected) {
        return Future.error(BaseModel(message: "Internet not connected"));
      }
      return await (_dio.post(
        endUrl,
        data: data,
        queryParameters: params,
        cancelToken: cancelToken ?? _cancelToken,
        options: options,
      )).catchError((e) {
        // if (!checkSessionExpire(e, context)) {
        //   throw e;
        // }
      });
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        return Future.error(BaseModel(message: "Poor internet connection"));
      }
      rethrow;
    }
  }

  Future<bool> checkInternet() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
