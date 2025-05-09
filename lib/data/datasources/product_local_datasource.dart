import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product_model.dart';

class ProductLocalDataSource {
  Future<List<ProductModel>> loadProducts() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/products.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => ProductModel.fromJson(json)).toList();
  }
}
// This code defines a ProductLocalDataSource class that loads product data from a local JSON file.
// It uses the rootBundle to load the JSON file and then decodes it into a list of ProductModel objects.