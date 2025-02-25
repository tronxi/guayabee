import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio_p;
import 'package:guayabee_app/exceptions/client_exception.dart';
import 'package:guayabee_app/exceptions/unauthorized_exception.dart';

import 'auth_service.dart';

class HttpService extends GetxService {
  final dio = dio_p.Dio();
  final url = dotenv.env['URL']!;
  final discoveryUrl = dotenv.env['REFRESH_TOKEN_URL']!;
  final AuthService _authService = Get.put(AuthService());

  HttpService._();

  static HttpService? _instance;

  factory HttpService() => _instance ??= HttpService._();
  Map<String, String> headers = {};

  Future<T> get<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    return await _handleRequest(() => _callGetApi(path, fromJson));
  }

  Future<List<T>> getList<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    return await _handleRequest(() => _callGetApiList(path, fromJson));
  }

  Future<T> post<T>(
    String path,
    Map<String, dynamic> data,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    return await _handleRequest(() => _callPostApi(path, data, fromJson));
  }

  Future<R> _handleRequest<R>(Future<R> Function() requestFunction) async {
    try {
      return await requestFunction();
    } on UnauthorizedException catch (e) {
      return await _handleUnauthorizedRequest<R>(requestFunction, e);
    } catch (e) {
      throw ClientException("$e");
    }
  }

  Future<R> _handleUnauthorizedRequest<R>(
    Future<R> Function() requestFunction,
    UnauthorizedException e,
  ) async {
    String? refreshToken = await _authService.getRefreshToken();
    if (refreshToken != null) {
      var response = await _refreshAccessToken(refreshToken);
      await _authService.login(
        response["accessToken"]!,
        response["refreshToken"],
      );
      return await requestFunction();
    } else {
      throw ClientException("$e");
    }
  }

  Future<T> _callGetApi<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      var options = await retrieveHeaders();
      var response = await dio.get("$url$path", options: options);

      if (response.statusCode == 200) {
        return fromJson(response.data);
      }

      throw _handleHttpError(response.statusCode);
    } on dio_p.DioException catch (e) {
      throw _handleHttpError(e.response?.statusCode);
    } catch (e) {
      throw ClientException("$e");
    }
  }

  Future<T> _callPostApi<T>(
    String path,
    Map<String, dynamic> data,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      var options = await retrieveHeaders();
      var response = await dio.post("$url$path", data: data, options: options);

      if (response.statusCode == 200) {
        return fromJson(response.data);
      }

      throw _handleHttpError(response.statusCode);
    } on dio_p.DioException catch (e) {
      throw _handleHttpError(e.response?.statusCode);
    } catch (e) {
      throw ClientException("$e");
    }
  }

  Future<List<T>> _callGetApiList<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      var options = await retrieveHeaders();
      var response = await dio.get("$url$path", options: options);

      if (response.statusCode == 200) {
        List<dynamic> jsonList = response.data;
        return jsonList
            .map((item) => fromJson(item as Map<String, dynamic>))
            .toList();
      }

      throw _handleHttpError(response.statusCode);
    } on dio_p.DioException catch (e) {
      throw _handleHttpError(e.response?.statusCode);
    } catch (e) {
      throw ClientException("$e");
    }
  }

  Future<dio_p.Options> retrieveHeaders() async {
    String? token = await _authService.getAccessToken();
    if (token != null) {
      return dio_p.Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );
    } else {
      return dio_p.Options(headers: {"Content-Type": "application/json"});
    }
  }

  Exception _handleHttpError(int? statusCode) {
    if (statusCode == 401) {
      return UnauthorizedException();
    }
    return ClientException("$statusCode");
  }

  Future<Map<String, String?>> _refreshAccessToken(String refreshToken) async {
    try {
      var response = await dio.post(
        discoveryUrl,
        options: dio_p.Options(
          headers: {"Content-Type": "application/x-www-form-urlencoded"},
        ),
        data: {
          "client_id": "guayabee-core",
          "refresh_token": refreshToken,
          "grant_type": "refresh_token",
        },
      );

      if (response.statusCode == 200) {
        return {
          "accessToken": response.data["access_token"],
          "refreshToken": response.data["refresh_token"],
        };
      } else {
        throw ClientException("${response.statusCode}");
      }
    } on dio_p.DioException catch (e) {
      throw ClientException("${e.response?.statusCode} - ${e.response?.data}");
    }
  }
}
