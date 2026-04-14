import 'package:flutter/material.dart';
import '../model/user_model.dart';
import '../services/hive_service.dart';

class AuthProvider extends ChangeNotifier {
  final HiveService _hiveService = HiveService();
  bool _isLoading = false;
  String? _errorMessage;
  UserModel? _currentUser;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null && _currentUser!.isLoggedIn;

  Future<void> checkLoginStatus() async {
    _isLoading = true;
    notifyListeners();
    _currentUser = await _hiveService.getCurrentUser();
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> register(UserModel user) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    final result = await _hiveService.register(user);
    _isLoading = false;
    if (!result['success']) {
      _errorMessage = result['error'];
    }
    notifyListeners();
    return result['success'];
  }

  Future<bool> login(String identifier, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    final result = await _hiveService.login(identifier, password);
    _isLoading = false;
    if (result['success']) {
      _currentUser = result['user'];
    } else {
      _errorMessage = result['error'];
    }
    notifyListeners();
    return result['success'];
  }

  Future<void> logout() async {
    await _hiveService.logout();
    _currentUser = null;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // ✅ أضف الدالة دي
  UserModel? getUserByIdentifier(String identifier) {
    final box = _hiveService.getUsersBox();
    try {
      return box.values.firstWhere(
            (user) =>
        user.email == identifier || user.phoneNumber == identifier,
      );
    } catch (e) {
      return null;
    }
  }
}