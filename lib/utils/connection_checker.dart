// utils/network_checker.dart
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

class NetworkChecker {
  final Connectivity _connectivity = Connectivity();

  // Stream for listening to network changes
  Stream<List<ConnectivityResult>> get onConnectivityChanged => _connectivity.onConnectivityChanged;

  // Check current internet connection status
  Future<bool> hasConnection() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
