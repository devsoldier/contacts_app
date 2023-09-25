import 'dart:developer';

import 'package:contacts_app/contacts/repository/data_classes/contacts_details.dart';
import 'package:contacts_app/contacts/repository/data_classes/pagination.dart';
import 'package:contacts_app/shared/result.dart';
import 'package:contacts_app/shared/services/api/api.dart';
import 'package:contacts_app/shared/services/api/dio_api_service/dio_config.dart';

///this class is for mock implementation
abstract class ContactsApiService {
  Future<Result<Pagination<ContactsDetails>>> getContacts({int? pageNo});
}

class ContactsApiWrapper extends ContactsApiService {
  final ApiService apiService;

  ContactsApiWrapper(this.apiService);

  @override
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
