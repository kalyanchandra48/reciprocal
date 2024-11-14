import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:reciprocal_task/models/product.dart';

class ProductsService {
  final String _baseUrl = 'https://fakestoreapi.com/products';

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> productsJson = json.decode(response.body);
      return productsJson
          .map((productsJson) => Product.fromMap(productsJson))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
