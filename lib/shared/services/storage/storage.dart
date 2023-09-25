import 'dart:io';

abstract class StorageService {
  Future<void> initStorage();
  Future<void> checkStoredDataExist(Directory appDir);
}
