import 'dart:developer';

import 'package:contacts_app/shared/service/api.dart';
import 'package:contacts_app/shared/service/dio_api_service/dio_config.dart';
import 'package:contacts_app/shared/service/result.dart';

import 'data_classes/pagination.dart';
import 'data_classes/contacts_details.dart';

class ContactsService {
  final ApiService apiService;

  ContactsService(this.apiService);

  Future<Result<Pagination<ContactsDetails>>> getContacts({
    int? pageNo,
  }) async {
    try {
      pageNo ??= 1;
      final response = await apiService.makeRequest(
        RequestMethod.get,
        '/users?page=$pageNo',
      );
      if (response.statusCode == 200) {
        final parsedResponse = Pagination<ContactsDetails>.fromJson(
          (response.data as Map<String, dynamic>),
          (json) => ContactsDetails.fromJson(json as Map<String, dynamic>),
        );
        return Result.success(parsedResponse);
      } else {
        return Result.failure('something went wrong');
      }
    } catch (e, s) {
      log('$e\n$s');
      return Result.failure('$e');
    }
  }
}
