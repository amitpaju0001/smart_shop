import 'package:flutter/material.dart';
import 'package:smart_shop/model/product_model.dart';
import 'package:smart_shop/service/api_service.dart';

class ApiProductProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();
  List<ProductModel> products = [];

  Future<void> fetchProducts() async {
    try {
      List<ProductModel> fetchedProducts = await ApiService.fetchProducts();
      products = fetchedProducts;
      notifyListeners();
    } catch (e) {
      print('Error fetched products: $e');
    }
  }
}