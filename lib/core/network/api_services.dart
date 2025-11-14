import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:news_app/core/network/secure_storage_services.dart';

class ApiService {
  final SecureStorageService secureStorageService;

  ApiService({required this.secureStorageService});

  static const String _baseUrl = 'https://newsapi.org/v2/everything';

  final Dio dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
  ));

  String? token;

  // Create a logger instance
  final Logger _logger = Logger();

  String getErrorMessage(DioException e) {
    final data = e.response?.data;

    if (data is Map<String, dynamic>) {
      final error = data['errors']?.toString();
      final message = data['message']?.toString();

      if ((error ?? '').toLowerCase().contains('timeout') ||
          (message ?? '').toLowerCase().contains('timeout')) {
        return 'Something went wrong. Please Try again later';
      }
      return error ?? message ?? 'Something went wrong. Please Try again later';
    }

    final str = data?.toString() ?? '';
    if (str.toLowerCase().contains('timeout')) {
      return 'Something went wrong. Please Try again later';
    }

    if (str.contains(':')) {
      return str.split(':').skip(1).join(':').trim();
    }

    return str.isNotEmpty
        ? str
        : 'Something went wrong. Please Try again later';
  }

  Future<Response<dynamic>> getApiData(
      {Map<String, dynamic>? queryParams, bool? isKnowledgeFeature}) async {
    try {
      _logger.i("getApiData to ${queryParams} with queryParam: $queryParams");

      final params = {
        "apiKey": "a7841b339acd44ebb3d9c9818b10f4d8",
        ...?queryParams,
      };

      final response = await dio.get(
        _baseUrl,
        queryParameters: params,
      );
      _logger.i(
          'GET request to $queryParams successful with response ${response.data}');
      return response;
    } on DioException catch (e) {
      _logger.e('DioError on GET request to $queryParams: $e');
      throw Exception("${e.response?.statusCode} - ${getErrorMessage(e)}");
    } catch (e) {
      _logger.e('Unexpected error on GET request to $queryParams: $e');
      rethrow;
    }
  }
}
