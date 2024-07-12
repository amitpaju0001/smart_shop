import 'dart:convert';

import 'package:smart_shop/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:smart_shop/service/api_endpoints.dart';

class UserApiService {
  Future<bool> registerUser(UserModel user) async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toMap()),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}