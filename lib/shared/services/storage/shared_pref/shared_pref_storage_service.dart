// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:contacts_app/shared/services/storage/storage.dart';

final sharedPreferencesStorageService =
    Provider.autoDispose((ref) => SharedPrefsStorageService());

class SharedPrefsStorageService extends StorageService {
  late final SharedPreferences sharedPrefs;

  @override
  Future<void> initStorage() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      await checkStoredDataExist(appDir);
      sharedPrefs = await SharedPreferences.getInstance();
    } catch (e, s) {
      log('storage setup: $e\n$s');
    }
  }

  @override
  Future<void> checkStoredDataExist(Directory appDir) async {
    try {
      final files = appDir.listSync(recursive: false, followLinks: false);
      log('files list: $files');
    } catch (e, s) {
      log('check stored data exist: $e\n$s');
    }
  }
}
