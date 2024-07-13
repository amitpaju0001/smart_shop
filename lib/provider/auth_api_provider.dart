import 'package:flutter/material.dart';
import 'package:smart_shop/model/auth_model.dart';
import 'package:smart_shop/service/auth_api_service.dart';

class AuthApiProvider with ChangeNotifier {
  final AuthApiService _apiService = AuthApiService();

  Future<bool> registerUser({
    required String username,
    required String password,
  }) async {
    AuthModel user = AuthModel(
      username: username,
      password: password,
    );
    bool registered = await _apiService.registerUser(user);
    notifyListeners();
    return registered;
  }
  Future<bool> loginUser({
    required String username,
    required String password,
  }) async {
    AuthModel user = AuthModel(
      username: username,
      password: password,
    );
    bool loggedIn = await _apiService.login(user);
    notifyListeners();
    return loggedIn;
  }
}
