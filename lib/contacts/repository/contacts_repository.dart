// ignore: unused_import
import 'dart:developer';

import 'package:contacts_app/contacts/repository/data_classes/contacts_details.dart';
import 'package:contacts_app/contacts/repository/helpers/contacts_helper.dart';
import 'package:contacts_app/contacts/repository/services/contacts_api_service.dart';
import 'package:contacts_app/shared/result.dart';
import 'package:contacts_app/shared/services/api/dio_api_service/dio_api.dart';
import 'package:contacts_app/shared/services/api/dio_api_service/dio_config.dart';
import 'package:contacts_app/shared/services/storage/shared_pref/shared_pref_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'services/contacts_storage_service.dart';

final contactsRepositoryProvider =
    Provider.autoDispose<ContactsRepository>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesStorageService);
  ref.keepAlive();
  return ContactsRepository(
    apiService: ContactsApiWrapper(DioApiService(dio)),
    storage: ContactsStorageService(sharedPrefs),
  );
});

class ContactsRepository {
  final ContactsApiService apiService;
  final ContactsStorageService storage;

  ContactsRepository({required this.apiService, required this.storage});

  List<ContactsDetails?> paginatedContactsList = [];
  List<ContactsDetails?> favouriteContactsList = [];
  bool isContactsLoaded = false;

  Future<Result<List<ContactsDetails?>>> retrieveAllPage() async {
    try {
      final response = await apiService.getContacts(pageNo: 1);
      final totalPage = response.data?.totalPages;
      if (totalPage == null || response.isFailure) {
        return Result.failure(response.message);
      }
      for (int i = 1; i <= totalPage; i++) {
        final contactsList = await apiService.getContacts(pageNo: i);
        paginatedContactsList.addAll(contactsList.data!.data);
      }
      return Result.success(paginatedContactsList);
    } on Exception catch (e, s) {
      return Result.failure('$e,$s');
    }
  }

  // Future<void> loadAllContacts() async {
  //   if (storage.hiveExist == false) {
  //     await retrieveAllPage();
  //     isContactsLoaded = true;
  //     await storage.storeContacts(paginatedContactsList);
  //   } else {
  //     await storage.retrieveContacts();
  //     paginatedContactsList = storage.contactsList;
  //   }
  // }

  // Future<void> syncContacts() async {
  //   paginatedContactsList = [];
  //   storage.hiveExist = true;
  //   await retrieveAllPage();
  //   await storage.storeContacts(paginatedContactsList);
  // }

  Future<void> loadFavouriteContacts() async {
    favouriteContactsList =
        ContactsHelper.favouriteFilter(paginatedContactsList);
  }

  Future<void> addContacts({
    String? email,
    String? firstName,
    String? lastName,
    bool? isFavourite,
  }) async {
    paginatedContactsList.add(
      ContactsDetails(
        id: paginatedContactsList.length + 1,
        email: email,
        firstName: firstName,
        lastName: lastName,
        isFavourite: isFavourite,
      ),
    );
    // await storage.storeContacts(paginatedContactsList);
  }

  Future<void> deleteContacts(ContactsDetails? contactsDetails) async {
    paginatedContactsList.remove(contactsDetails);
    // await storage.storeContacts(paginatedContactsList);
  }

  Future<void> updateContacts({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    bool? isFavourite,
  }) async {
    log('paginated length ${paginatedContactsList.length}');
    ContactsDetails? matchedContact = paginatedContactsList[
        paginatedContactsList.indexWhere((element) => element?.id == id)];

    // matchedContact?.firstName = firstName ?? matchedContact.firstName;
    // matchedContact?.lastName = lastName ?? matchedContact.lastName;
    // matchedContact?.email = email ?? matchedContact.email;
    // matchedContact?.isFavourite = isFavourite ?? matchedContact.isFavourite;

    matchedContact?.copyWith(
      firstName: firstName ?? matchedContact.firstName,
      lastName: lastName ?? matchedContact.lastName,
      email: email ?? matchedContact.email,
      isFavourite: isFavourite ?? matchedContact.isFavourite,
    );

    // await storage.storeContacts(paginatedContactsList);
  }

  Future<List<ContactsDetails?>?> searchContacts({
    String? searchQuery,
    int? pageIndex,
  }) async {
    if (pageIndex == 0) {
      final filterResult =
          ContactsHelper.searchFilter(paginatedContactsList, searchQuery);
      return filterResult;
    } else {
      final filterResult =
          ContactsHelper.searchFilter(favouriteContactsList, searchQuery);
      return filterResult;
    }
  }
}
