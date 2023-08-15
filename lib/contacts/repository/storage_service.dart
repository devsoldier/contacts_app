import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:contacts_app/contacts/repository/data_classes/contacts_details.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

const kContactsBox = 'contactsBox';
const kBoxDirectoryPath = 'hiveBoxes';
const kContacts = 'kContacts';

class StorageService {
  late final Box hiveBox;
  List<ContactsDetails?> contactsList = [];

  Future<void> hiveSetup() async {
    try {
      var appDir = await getApplicationDocumentsDirectory();
      var hiveDb = Directory('${appDir.path}/$kBoxDirectoryPath');
      Hive.init(hiveDb.path);
      hiveBox = await Hive.openBox(kContactsBox);
      log('hive initialized');
    } catch (e, s) {
      log('$e\n$s');
    }
  }

  storeContacts(List<ContactsDetails?> value) async {
    final json = jsonEncode(value);
    await hiveBox.put(kContacts, json);
  }

  retrieveContacts() async {
    final box = hiveBox.get(kContacts);
    if (box != null) {
      final decoded = jsonDecode(box);
      log('${decoded.runtimeType}');
      contactsList =
          (decoded as List).map((e) => ContactsDetails.fromJson(e)).toList();
    }
  }
}
