import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../feature/auth/application/auth_manager.dart';
import '../api/endpoints.dart';

final networkRequestProvider = Provider<NetworkRequest>(
  (ref) => NetworkRequestImpl(),
);

abstract class NetworkRequest {
  Future<Response> get(
    String url, {
    Object? body,
    Map<String, String>? headers,
  });
  Future<Response> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });

  Future<Response> postMultipart(
    String url, {
    required Map<String, File> files,
    required Map<String, String> fields,
    Map<String, String>? headers,
  });
  Future<Response> patch(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });
  Future<Response> put(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });
  Future<Response> delete(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  });
}

class NetworkRequestImpl implements NetworkRequest {
  final Dio _dio;

  NetworkRequestImpl()
    : _dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(minutes: 2),
          receiveTimeout: const Duration(minutes: 5),
          sendTimeout: const Duration(minutes: 2),
          validateStatus: (status) => status != null && status < 500,
        ),
      ) {
    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (options.uri.toString().startsWith(Endpoints.base)) {
            final accessToken = AuthManager.instance.accessToken;

            if (accessToken != null) {
              options.headers['Authorization'] = 'Bearer $accessToken';
            }
          }

          handler.next(options);
        },
      ),
    );
  }

  @override
  Future<Response> get(
    String url, {
    Object? body,
    Map<String, String>? headers,
  }) {
    return _dio.get(url, options: Options(headers: headers));
  }

  @override
  Future<Response> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    return _dio.post(
      url,
      data: body,
      options: Options(headers: headers),
    );
  }

  @override
  Future<Response> postMultipart(
    String url, {
    required Map<String, File> files,
    required Map<String, String> fields,
    Map<String, String>? headers,
  }) async {
    final formData = FormData();

    // Add fields
    fields.forEach((key, value) {
      formData.fields.add(MapEntry(key, value));
    });

    // Add files
    for (final entry in files.entries) {
      final file = await MultipartFile.fromFile(
        entry.value.path,
        filename: entry.value.uri.pathSegments.last,
      );
      formData.files.add(MapEntry(entry.key, file));
    }

    return _dio.post(
      url,
      data: formData,
      options: Options(
        headers: {...?headers, 'Content-Type': 'multipart/form-data'},
      ),
    );
  }

  @override
  Future<Response> patch(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    return _dio.patch(
      url,
      data: body,
      options: Options(headers: headers),
    );
  }

  @override
  Future<Response> put(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    return _dio.put(
      url,
      data: body,
      options: Options(headers: headers),
    );
  }

  @override
  Future<Response> delete(
    String url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    return _dio.delete(
      url,
      data: body,
      options: Options(headers: headers),
    );
  }
}

extension ResponseExtension on Response {
  bool get isSuccess =>
      statusCode != null && statusCode! >= 200 && statusCode! < 300;
}
