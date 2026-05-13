import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductService {
  static const String baseUrl = 'https://dummyjson.com';

  Future<List<Product>> getProducts({int limit = 100, int skip = 0}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/products?limit=$limit&skip=$skip'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List products = data['products'];
      return products.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat produk: ${response.statusCode}');
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/products/search?q=${Uri.encodeComponent(query)}'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List products = data['products'];
      return products.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Gagal mencari produk: ${response.statusCode}');
    }
  }

  Future<Product> getProductById(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/products/$id'),
    );

    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal memuat produk: ${response.statusCode}');
    }
  }
}
