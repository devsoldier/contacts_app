import 'package:dio/dio.dart';

import 'dio_api_service/dio_config.dart';

///this class is for Fake implementation
abstract class ApiService {
  Future<Response> makeRequest(
    RequestMethod method,
    String path, {
    Map<String, dynamic>? body,
  });
}
