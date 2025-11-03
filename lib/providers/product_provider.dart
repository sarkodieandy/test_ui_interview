import 'package:flutter/material.dart';
import 'package:test/services/api_service.dart';
import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _service = ProductService();

  List<Product> _products = [];
  bool isLoading = false;

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();

    try {
      _products = await _service.fetchProducts();
    } catch (e) {
      debugPrint('Error fetching products: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void toggleFavorite(int id) {
    final index = _products.indexWhere((p) => p.id == id);
    if (index != -1) {
      _products[index].isFavorite = !_products[index].isFavorite;
      notifyListeners();
    }
  }
}
