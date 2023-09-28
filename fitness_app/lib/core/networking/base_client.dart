import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:fitness_app/core/utils/strings.dart';
import 'base_response.dart';

class ApiManager{
  static String get baseUrl => "https://dummyjson.com/";
  static Dio dioClient = _addInterceptors(_createDio());
  static Dio _createDio() {
    BaseOptions opts = BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.json,
      connectTimeout: Strings.dioTimeOutDuration,
      receiveTimeout: Strings.dioTimeOutDuration,
    );
    return Dio(opts);
  }

  static Dio _addInterceptors(Dio dio) {
    // ignore: avoid_single_cascade_in_expression_statements
    dio
      ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        return handler.next(options); //continue
      }, onResponse: (response, handler) {
        return handler.next(response); // continue
      }, onError: (DioError error, handler) async {
        var e = DioErrorHandler.dioErrorToString(error);
        return handler.next(error);
      }));
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    dio.options.headers['content-Type'] = 'application/json';
      return client;
    };
   // dio.options.contentType = ContentType("application","x-www-form-urlencoded") as String;
    return dio;
  }

  static Future<ApiResponse?> get(String url) async {
    try {
      Response response = await dioClient.get(url);
      return ApiResponse.parse(response);
    } catch (e) {
      return ApiResponse.parse(e);
    }
  }

}