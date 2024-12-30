import 'dart:convert';
import 'package:appstore/helper/api_config.dart';
import 'package:http/http.dart' as http;
import 'package:appstore/Model/category_model.dart';
import 'package:flutter/material.dart';

class AllCategoryService {
  Future<List<CategoryModel>> getCategories(BuildContext context) async {
    final headers = ApiConfig.getHeaders(context);

    http.Response response = await http.get(
      Uri.parse('https://student.valuxapps.com/api/categories'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> data = jsonData['data']['data'];

      List<CategoryModel> categoryList = [];
      for (var item in data) {
        categoryList.add(CategoryModel.fromJson(item));
      }
      return categoryList;
    } else {
      throw Exception('Failed to load categories. Status code: ${response.statusCode}');
    }
  }
}
