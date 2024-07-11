import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:smart_shop/model/product_model.dart';
import 'package:smart_shop/provider/api_endpoints.dart';
class ApiService {
  static Future<ProductModel> fetchProduct(String productId) async {
    String url = '${ApiEndpoints.product}/$productId';
    Uri uri = Uri.parse(url);
    Response response = await http.get(uri);
    if (response.statusCode == 200) {
      String body = response.body;
      var json = jsonDecode(body);
      ProductModel productModel = ProductModel.fromJson(json);
      return productModel;
    } else {
      throw 'Something went wrong';
    }
  }
}
