import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_shop/model/product_model.dart';
import 'package:smart_shop/service/api_endpoints.dart';

class ApiService {
  static Future<ProductModel> fetchProduct(String productId) async {
    String url = '${ApiEndpoints.product}/$productId';
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      String body = response.body;
      var json = jsonDecode(body);
      ProductModel productModel = ProductModel.fromJson(json);
      return productModel;
    } else {
      throw 'Something went wrong';
    }
  }

  static Future<List<ProductModel>> fetchProducts() async {
    Uri uri = Uri.parse(ApiEndpoints.product);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      String body = response.body;
      List<dynamic> listMap = jsonDecode(body);
      List<ProductModel> productList = [];
      for (var i in listMap) {
        ProductModel productModel = ProductModel.fromJson(i);
        productList.add(productModel);
      }

      return productList;
    } else {
      throw 'Something went wrong';
    }
  }
}