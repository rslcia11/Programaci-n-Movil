import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class DataService {
  static Future<List<dynamic>> loadProducts() async {
    final String response = await rootBundle.loadString('assets/data/products.json');
    return json.decode(response);
  }
}