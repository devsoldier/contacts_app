import 'dio_api_service/dio_config.dart';
import 'package:dio/dio.dart';

abstract class ApiService {
  Future<Response> makeRequest(
    RequestMethod method,
    String path, {
    Map<String, dynamic>? body,
  });
}
