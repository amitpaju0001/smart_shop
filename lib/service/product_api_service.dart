import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:smart_shop/model/product_model.dart';
import 'package:smart_shop/shared/api_endpoints.dart';
import 'package:smart_shop/shared/string_const.dart';

class ProductApiService {
  static Future<ProductModel> fetchProduct(String productId) async {
    String url = '${ApiEndpoints.product}/$productId';
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri, headers: {
      'Authorization': 'Bearer ${ApiEndpoints.authToken}',
    });
    if (response.statusCode == 200) {
      String body = response.body;
      var json = jsonDecode(body);
      ProductModel productModel = ProductModel.fromJson(json);
      return productModel;
    } else {
      throw StringConst.throwWrong;
    }
  }
  static Future<List<ProductModel>> fetchProducts() async {
    Uri uri = Uri.parse(ApiEndpoints.product);
    http.Response response = await http.get(uri, headers: {
      'Authorization': 'Bearer ${ApiEndpoints.authToken}',
    });
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
      throw StringConst.throwWrong;
    }
  }

  static Future<String> addProduct(ProductModel productModel) async {
    Uri uri = Uri.parse(ApiEndpoints.product);
    Map<String, dynamic> map = productModel.toJson();
    map.remove('id');
    String mapStr = jsonEncode(map);

    Response response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ApiEndpoints.authToken}',
      },
      body: mapStr,
    );

    if (response.statusCode == 201) {
      return StringConst.returnAdd;
    } else {
      throw StringConst.throwWrong;
    }
  }
  static Future<String> updateProduct(
      String productId, ProductModel productModel) async {
    Map<String, dynamic> map = productModel.toJson();
    String mapStr = jsonEncode(map);
    Uri uri = Uri.parse('${ApiEndpoints.product}/$productId');
    Response response = await http.put(uri, body: mapStr, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${ApiEndpoints.authToken}',
    });
    if (response.statusCode == 200) {
      return StringConst.returnUpdate;
    } else {
      throw StringConst.throwWrong;
    }
  }

  static Future<void> deleteProduct(String productId) async {
    Uri uri = Uri.parse('${ApiEndpoints.product}/$productId');
    Response response = await http.delete(uri, headers: {
      'Authorization': 'Bearer ${ApiEndpoints.authToken}',
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
    } else {
      throw '${StringConst.throwFailed} ${response.statusCode}';
    }
  }
}
