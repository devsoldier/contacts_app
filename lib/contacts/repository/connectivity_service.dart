import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final controller = StreamController<bool>.broadcast();
  final connectivity = Connectivity();
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  bool isOnline = false;

  subscribeConnectivity() async {
    log('connectivity initialized');
    // controller.stream.listen((event) => log('initial connectivity: ${event}'));
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      connectivityResult = result;
      await checkIfHasInternet();
    });
  }

  checkIfHasInternet() async {
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

  //   void _checkStatus(ConnectivityResult result) async {
  //   bool isOnline = false;
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       log('[MyConnectivity] online');
  //       isOnline = true;
  //     } else {
  //       log('[MyConnectivity] offline');
  //       isOnline = false;
  //     }
  //   } on SocketException catch (_) {
  //     isOnline = false;
  //   }
  //   controller.sink.add({result: isOnline});
  // }
}
