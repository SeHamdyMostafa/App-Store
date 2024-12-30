import 'dart:convert';
import 'package:appstore/helper/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:appstore/Model/Product_Model.dart';
import 'package:flutter/material.dart';

class ProductsOfCategoryService {
  Future<List<ProductModel>> getProductsOfCategory({
    required int categoryId,
    required BuildContext context, // تمرير الـ context
  }) async {
    final headers = ApiConfig.getHeaders(context);

    http.Response response = await http.get(
      Uri.parse("https://student.valuxapps.com/api/products?category_id=$categoryId"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> data = jsonData['data']['data']; 

      List<ProductModel> productsOfCategoryList = [];

      for (var product in data) {
        productsOfCategoryList.add(ProductModel.fromJson(product));
      }

      return productsOfCategoryList;
    } else {
      throw Exception('Failed to load products. Status code: ${response.statusCode}');
    }
  }
}
