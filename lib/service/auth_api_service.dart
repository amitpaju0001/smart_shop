import 'dart:convert';
import 'package:smart_shop/model/auth_model.dart';
import 'package:http/http.dart' as http;
import 'package:smart_shop/shared/api_endpoints.dart';

class AuthApiService {
  Future<bool> registerUser(AuthModel user) async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toMap()),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> login(AuthModel user) async {
    final url = Uri.parse('${ApiEndpoints.baseUrl}/login');
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
