import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fitness_app/core/utils/strings.dart';


BaseResponse baseResponseFromJson(String str) =>
    BaseResponse.fromJson(json.decode(str));

String baseResponseToJson(BaseResponse data) => json.encode(data.toJson());

class BaseResponse {
  BaseResponse({
    this.message,
    this.statusCode,
    this.errorMessage,
    this.data,
  });

  String? message;
  int? statusCode;
  String? errorMessage;
  dynamic data;

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
    message: json["Message"],
    statusCode: json["StatusCode"],
    errorMessage: json["errorMessage"],
    data: json["Data"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "statusCode": statusCode,
    "errorMessage": errorMessage,
    "data": data.toJson(),
  };
}


///Internal process response

enum Status { loading, completed, error }

class ApiResponse {
  Status status;
  BaseResponse? baseResponse;
  String? errMessage;

  ApiResponse(
      {required this.status,
        this.baseResponse,
        this.errMessage});

  static Future<ApiResponse?> parse(dynamic value) async {
    try {
      if (value is Response) {
        if (value.data is List<dynamic>) {
          BaseResponse(message: '', statusCode: 200, data: value.data);
          return ApiResponse(
              status: Status.completed,
              baseResponse:
              BaseResponse(message: '', statusCode: 200, data: value.data));
        } else {
          return ApiResponse(
              status: Status.completed,
              baseResponse:
              BaseResponse(message: '', statusCode: 200, data: value.data));
        }
      } else if (value is DioError) {
        var errorMsg = DioErrorHandler.dioErrorToString(value);
        return ApiResponse(status: Status.error, errMessage: errorMsg);
      } else {
        return ApiResponse(
            status: Status.error, errMessage: 'Something went wrong!');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  String toString() {
    return "Status : $status \n Message : $errMessage \n Data : ${baseResponse?.data}";
  }
}

class DioErrorHandler {
  static String? dioErrorToString(DioException dioError) {
    String? errorMessage;
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = Strings.connectTimeout;
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = Strings.receiveTimeout;
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = Strings.sendTimeout;
        break;
      case DioExceptionType.badResponse:
        errorMessage = _errorBaseOnHttpStatusCode(dioError);
        break;
      case DioExceptionType.connectionError:
        errorMessage = Strings.connectionToAPIServerFailedError;
        break;
      case DioExceptionType.unknown:
        errorMessage = Strings.connectionToAPIServerFailedError;
        break;
      case DioExceptionType.cancel:
        errorMessage = Strings.cancel;
        break;
      case DioExceptionType.badCertificate:
        errorMessage = Strings.invalidCredentials;
        break;
    }
    return errorMessage;
  }

  static String _errorBaseOnHttpStatusCode(DioError dioError) {
    String errorText;
    if (dioError.response != null) {
      if (dioError.response!.statusCode == 401) {
        errorText =
        "Something went wrong, please close the app and login again.";
      } else if (dioError.response!.statusCode == 404) {
        errorText =
        "Something went wrong, please close the app and login again.";
      } else if (dioError.response!.statusCode == 500) {
        errorText = "We couldn't connect to the product server";
      } else if (dioError.response!.statusCode == 400) {
        if (dioError.response?.data != '') {
          var data = jsonDecode(dioError.response?.data);
          if (data != null) {
            errorText = data['errors']['Error Message'][0];
          } else {
            errorText =
            "Something went wrong, please close the app and login again.";
          }
        } else {
          errorText =
          "Something went wrong, please close the app and login again.";
        }
      } else {
        errorText =
        "Something went wrong, please close the app and login again.";
      }
    } else {
      errorText = "Something went wrong, please close the app and login again.";
    }
    return errorText;
  }
}

