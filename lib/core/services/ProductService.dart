import 'dart:convert';
import 'package:eshop/core/models/ProductModel.dart';
import 'package:http/http.dart' as http;

class ProductService {

  ProductService();

  Future<ProductModel> fetchProducts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return  ProductModel.fromJson(data);

    } else {
      throw Exception('Failed to load products');
    }
  }
}
