import 'package:dio/dio.dart';

final _baseOption = BaseOptions();

final dio = Dio(_baseOption);

enum RequestMethod {
  get,
  head,
  post,
  put,
  patch,
  delete,
  connect,
  option,
  trace,
}

extension RequestMethodExtension on RequestMethod {
  String toValue() {
    switch (this) {
      case RequestMethod.head:
        return 'HEAD';
      case RequestMethod.post:
        return 'POST';
      case RequestMethod.put:
        return 'PUT';
      case RequestMethod.patch:
        return 'PATCH';
      case RequestMethod.delete:
        return 'DELETE';
      case RequestMethod.connect:
        return 'CONNECT';
      case RequestMethod.option:
        return 'OPTION';
      case RequestMethod.trace:
        return 'TRACE';
      case RequestMethod.get:
      default:
        return 'GET';
    }
  }
}
