import 'package:dio/dio.dart';
import 'package:diary_mobile/core/constant/app_environment.dart';

class DioManager {
  static Dio getDio() {
    Dio dio = Dio();

    dio.options.baseUrl = AppEnvironment().domain;

    dio.options.headers = {"Accept": "application/json", "Content-Type": "application/json"};

    dio.options.validateStatus = (status) => status! < 500 && status != 401;

    dio.options.responseType = ResponseType.plain;

    dio.interceptors.add(
      LogInterceptor(requestBody: true, error: true, responseBody: true, requestHeader: true, responseHeader: true, request: true),
    );

    return dio;
  }
}
