import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final controller = StreamController<bool>.broadcast();
  Stream get connectivityStream => controller.stream;
  final connectivity = Connectivity();
  bool isOnline = false;

  Future<void> subscribeConnectivity() async {
    try {
      log('connectivity initialized');
      Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        log('connectivity: $result');
        await checkIfHasInternet();
      });
    } on Exception catch (e, s) {
      log('subscribeConnectivity: $e\n$s');
    }
  }

  Future<void> checkIfHasInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
        log('internet status: online');
        isOnline = true;
      } else {
        log('internet status: offline');
        isOnline = false;
      }
    } on SocketException catch (_) {
      log('internet status: offline');
      isOnline = false;
    }

    controller.sink.add(isOnline);
  }
}
