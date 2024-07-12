import 'package:flutter/material.dart';
import 'package:smart_shop/model/user_model.dart';
import 'package:smart_shop/service/user_api_service.dart';

class UserApiProvider with ChangeNotifier {
  final UserApiService _apiService = UserApiService();

  Future<bool> registerUser({
    required String username,
    required String password,
  }) async {
    UserModel user = UserModel(
      username: username,
      password: password,
    );
    bool registered = await _apiService.registerUser(user);
    notifyListeners();
    return registered;
  }
}
