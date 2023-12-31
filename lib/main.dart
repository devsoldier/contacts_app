import 'dart:async';

import 'package:contacts_app/contacts/repository/api_service_wrapper.dart';
import 'package:contacts_app/contacts/repository/connectivity_service.dart';
import 'package:contacts_app/contacts/repository/storage_service.dart';

import 'contacts/repository/contacts_service.dart';
import 'shared/service/dio_api_service/dio_api.dart';
import 'shared/service/dio_api_service/dio_config.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependenciesSetup();
  runApp(const App());
}

Future<void> dependenciesSetup() async {
  final connectivityListener =
      GetIt.I.registerSingleton<ConnectivityService>(ConnectivityService());

  await connectivityListener.subscribeConnectivity();

  final storage = GetIt.I.registerSingleton<StorageService>(StorageService());

  await storage.hiveSetup();

  await storage.retrieveContacts();

  GetIt.I.registerSingleton<ContactsService>(
    ContactsService(
      apiService: ApiServiceWrapper(DioApiService(dio)),
      storage: storage,
    ),
  );

  final logInterceptor = LogInterceptor(
    request: true,
    requestHeader: true,
    requestBody: false,
    error: true,
    responseHeader: false,
    responseBody: true,
  );

  dio.interceptors.addAll([
    logInterceptor,
  ]);
}
