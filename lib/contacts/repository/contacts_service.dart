// ignore: unused_import
import 'dart:developer';

import 'package:contacts_app/contacts/repository/contacts_helper.dart';
import 'package:contacts_app/contacts/repository/storage_service.dart';
import 'package:contacts_app/shared/service/result.dart';

import 'api_service_wrapper.dart';
import 'data_classes/pagination.dart';
import 'data_classes/contacts_details.dart';

class ContactsService {
  final ApiServiceWrapper apiService;
  final StorageService storage;
  Result<Pagination<ContactsDetails>>? result = Result.loading();
  List<ContactsDetails?> paginatedContactsList = [];
  List<ContactsDetails?> favouriteContactsList = [];
  bool isContactsLoaded = false;

  ContactsService({required this.apiService, required this.storage});

  Future<void> retrieveAllPage() async {
    final response = await apiService.getContacts(pageNo: 1);
    result = response;
    final totalPage = response.data?.totalPages;
    if (totalPage == null || response.isFailure) return;
    for (int i = 1; i <= totalPage; i++) {
      final contactsList = await apiService.getContacts(pageNo: i);
      paginatedContactsList.addAll(contactsList.data!.data);
    }
  }

  Future<void> loadAllContacts() async {
    if (storage.hiveExist == false) {
      await retrieveAllPage();
      isContactsLoaded = true;
      await storage.storeContacts(paginatedContactsList);
    } else {
      paginatedContactsList = storage.contactsList;
    }
  }

  Future<void> syncContacts() async {
    paginatedContactsList = [];
    await retrieveAllPage();
    storage.hiveExist = true;
    await storage.storeContacts(paginatedContactsList);
  }

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
    await storage.storeContacts(paginatedContactsList);
  }

  Future<void> deleteContacts(ContactsDetails? contactsDetails) async {
    paginatedContactsList.remove(contactsDetails);
    await storage.storeContacts(paginatedContactsList);
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

    matchedContact?.firstName = firstName ?? matchedContact.firstName;
    matchedContact?.lastName = lastName ?? matchedContact.lastName;
    matchedContact?.email = email ?? matchedContact.email;
    matchedContact?.isFavourite = isFavourite ?? matchedContact.isFavourite;
    await storage.storeContacts(paginatedContactsList);
  }

  Future<List<ContactsDetails?>?> searchContacts({
    String? searchQuery,
  }) async {
    final filterResult =
        ContactsHelper.searchFilter(paginatedContactsList, searchQuery);
    return filterResult;
  }
}
