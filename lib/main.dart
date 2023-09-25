import 'package:contacts_app/shared/services/api/dio_api_service/dio_config.dart';
import 'package:contacts_app/shared/services/connectivity_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'package:flutter/material.dart';

import 'shared/services/storage/shared_pref/shared_pref_storage_service.dart';

void main() async {
  final container = ProviderContainer();
  WidgetsFlutterBinding.ensureInitialized();
  await dependenciesSetup(container);
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const App(),
    ),
  );
}

Future<void> dependenciesSetup(ProviderContainer container) async {
  await Future.wait([
    container.read(connectivityService).subscribeConnectivity(),
    container.read(sharedPreferencesStorageService).initStorage(),
  ]);

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
