import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:contacts_app/contacts/repository/data_classes/contacts_details.dart';
import 'package:contacts_app/shared/services/storage/shared_pref/shared_pref_storage_service.dart';

const kContacts = 'kContacts';

class ContactsStorageService {
  SharedPrefsStorageService storageService;

  ContactsStorageService(this.storageService);

  SharedPreferences get sharedPrefs => storageService.sharedPrefs;

  Future<void> storeContacts(List<ContactsDetails?> value) async {
    try {
      final json = jsonEncode(value);
      await sharedPrefs.setString(kContacts, json);
    } catch (e, s) {
      log('store contacts: $e\n$s');
    }
  }

  Future<List<ContactsDetails?>> retrieveContacts() async {
    try {
      final storedContacts = sharedPrefs.getString(kContacts).toString();
      final decoded = jsonDecode(storedContacts);
      List<ContactsDetails?> contactsList =
          (decoded as List).map((e) => ContactsDetails.fromJson(e)).toList();
      return contactsList;
    } catch (e, s) {
      log('retrieve contacts: $e\n$s');
      throw Exception('$e\n$s');
    }
  }
}
