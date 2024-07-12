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


  Future<void> addProduct(ProductModel product) async {
    try {
      await ApiService.addProduct(product);
      await fetchProducts();
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  Future<void> updateProduct(String productId, ProductModel product) async {
    try {
      await ApiService.updateProduct(productId, product);
      await fetchProducts();
      notifyListeners();
    } catch (e) {
      print('Error updating product: $e');
    }
  }

}