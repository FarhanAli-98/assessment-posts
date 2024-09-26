// providers/post_provider.dart
import 'package:assessment/data/source/api/api_service.dart';
import 'package:assessment/utils/connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../../models/post.dart';

class PostProvider extends ChangeNotifier {
  List<Post> _posts = [];
  bool _isLoading = false;
  String? _errorMessage;
  bool _isConnected = false; // Track connection status

  final NetworkChecker _networkChecker = NetworkChecker();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isConnected => _isConnected;

  PostProvider() {
    // Subscribe to connectivity changes when provider is created
    _connectivitySubscription = _networkChecker.onConnectivityChanged.listen(_handleConnectivityChange);
  }

  // Fetch posts from API and handle internet connectivity and errors
  Future<void> fetchPosts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    bool isConnected = await _networkChecker.hasConnection();
    if (!isConnected) {
      _isConnected = false;
      _errorMessage = 'No internet connection. Please check your connection.';
      _isLoading = false;
      notifyListeners();
      return;
    }

    _isConnected = true; // Reset connection flag if connected
    try {
      _posts = await ApiService.fetchPosts();
    } catch (e) {
      _errorMessage = 'Failed to load posts. Please try again later.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Handle network changes and auto-reload data when reconnected
  void _handleConnectivityChange(List<ConnectivityResult> result) {
    if (result.first != ConnectivityResult.none) {
      if (!_isConnected) {
        // If previously disconnected, refetch posts when connection is restored
        fetchPosts();
        _isConnected = true;
      }
    } else {
      _isConnected = false;
      _errorMessage = 'No internet connection. Please check your connection.';
      notifyListeners();
    }
  }

  // Refresh posts
  Future<void> refreshPosts() async {
    await fetchPosts();
  }

  @override
  void dispose() {
    // Cancel connectivity subscription when provider is disposed
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
