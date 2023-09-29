import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:naser_alqtami/core/api/request_type.dart';
import 'package:path_provider/path_provider.dart';

import '../../injection_container.dart';
import '../errors/exceptions.dart';
import 'api_consumer.dart';
import 'app_interceptors.dart';
import 'end_points.dart';
import 'status_code.dart';

class DioConsumer implements ApiConsumer {
  final Dio client;

  DioConsumer({required this.client}) {
    client.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      },
    );

    client.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };
    client.interceptors.add(serviceLoctor<AppIntercepters>());
    if (kDebugMode) {
      client.interceptors.add(serviceLoctor<LogInterceptor>());
    }
  }

  @override
  Future request(String path, String? requestType, {Map<String, dynamic>? body, Map<String, dynamic>? queryParameters}) async {
    Response? response;

    try {
      switch (requestType) {
        case RequestType.get:
          response = await client.get(path, queryParameters: queryParameters);
          break;
        case RequestType.post:
          response = await client.post(path, queryParameters: queryParameters, data: body);
          break;
        case RequestType.put:
          response = await client.put(path, queryParameters: queryParameters, data: body);
      }

      if (response!.statusCode == StatusCode.ok) {
        return _handleResponseAsJson(response);
      } else {
        _handleDioStatusCode(response.statusCode);
      }
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future<dynamic> downloadAndSaveFile(String url, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';

    try {
      final response = await client.download(url, filePath);
      if (response.statusCode == StatusCode.ok) {
        Logger().d(filePath);
        return filePath;
      } else {
        _handleDioStatusCode(response.statusCode);
      }
    } on DioException catch (error) {
      _handleDioError(error);
    }
  }

  dynamic _handleResponseAsJson(Response<dynamic> response) {
    final responseJson = jsonDecode(response.data.toString());
    return responseJson;
  }

  dynamic _handleDioError(DioException error) {
    Logger().i('🌐🌐ERROR in http ${error.type} 🌐🌐\n$error');
    Logger().e(error.response?.data);
    Logger().wtf(error.message);
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw const FetchDataException();
      case DioExceptionType.badResponse:
        _handleDioStatusCode(error.response?.statusCode);
        break;

      case DioExceptionType.cancel:
        break;
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        throw const NoInternetConnectionException();

      default:
        throw const UnknowError();
    }
  }

  dynamic _handleDioStatusCode(int? statusCode) {
    switch (statusCode) {
      case StatusCode.badRequest:
        throw const BadRequestException();
      case StatusCode.unauthorized:
      case StatusCode.forbidden:
        throw const UnauthorizedException();
      case StatusCode.notFound:
        throw const NotFoundException();
      case StatusCode.confilct:
        throw const ConflictException();
      case StatusCode.internalServerError:
        throw const InternalServerErrorException();
      default:
        throw const UnknowError();
    }
  }
}
