import 'package:flutter/material.dart';
import 'package:smart_shop/model/product_model.dart';
import 'package:smart_shop/service/product_api_service.dart';

class ApiProductProvider extends ChangeNotifier {
  final ProductApiService apiService = ProductApiService();
  List<ProductModel> products = [];

  Future<void> fetchProducts() async {
    try {
      List<ProductModel> fetchedProducts = await ProductApiService.fetchProducts();
      products = fetchedProducts;
      notifyListeners();
    } catch (e) {
      return;
    }
  }


  Future<void> addProduct(ProductModel product) async {
    try {
      await ProductApiService.addProduct(product);
      await fetchProducts();
    } catch (e) {
    return;
    }
  }

  Future<void> updateProduct(String productId, ProductModel product) async {
    try {
      await ProductApiService.updateProduct(productId, product);
      await fetchProducts();
      notifyListeners();
    } catch (e) {
     return;
    }
  }
  Future<void> deleteProduct(String productId) async {
    try {
      await ProductApiService.deleteProduct(productId);
      await fetchProducts();
      notifyListeners();
    } catch (e) {
      return;
    }
  }
}