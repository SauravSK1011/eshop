import 'dart:convert';
import 'package:eshop/core/models/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  ProductModel? _productModel;
  bool _isLoading = false;
  String? _errorMessage;

  ProductModel? get productModel => _productModel;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchProducts() async {
    _isLoading = true;
      notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://dummyjson.com/products'));

      if (response.statusCode == 200) {
        _productModel = ProductModel.fromJson(jsonDecode(response.body));
        _errorMessage = null;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (error) {
      _errorMessage = error.toString();
      _productModel = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
