import 'dart:convert';
import 'package:appstore/helper/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:appstore/Model/Product_Model.dart';
import 'package:flutter/material.dart';

class SearchService {
  Future<List<ProductModel>> getAllProducts({required BuildContext context}) async {
    final headers = ApiConfig.getHeaders(context);

    http.Response response = await http.get(
      Uri.parse('https://student.valuxapps.com/api/products'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> data = jsonData['data']['data'];
      return data.map((item) => ProductModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch products. Status code: ${response.statusCode}');
    }
  }

 Future<List<ProductModel>> searchProduct({required String query, required BuildContext context}) async {
  final headers = ApiConfig.getHeaders(context);

  http.Response response = await http.post(
    Uri.parse('https://student.valuxapps.com/api/products/search'),
    headers: headers,
    body: jsonEncode({'text': query}), // تحويل البيانات إلى JSON
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    List<dynamic> data = jsonData['data']['data'];
    return data.map((item) => ProductModel.fromJson(item)).toList();
  } else {
    throw Exception('Failed to search products. Status code: ${response.statusCode}');
  }
}



}
