import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import '../../utils/app_utils/app_strings.dart';

class AppIntercepters extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    options.headers[AppStrings.contentType] = AppStrings.applicationJson;
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Logger().e('🌐🌐ERROR message[${err.message}] \n 🌐🌐 PATH: ${err.requestOptions.path}\n 🌐🌐 response: ${err.response}\n 🌐🌐 type: ${err.type}🌐🌐\n statusCode: ${err.response?.statusCode}');
    super.onError(err, handler);
  }
}
