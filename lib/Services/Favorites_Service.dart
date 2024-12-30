import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:appstore/helper/api_config.dart';
import 'package:appstore/Model/Product_Model.dart';

class FavoritesService {
  Future<void> addToFavorites({
    required int productId,
    required BuildContext context,
  }) async {
    final headers = ApiConfig.getHeaders(context);

    http.Response response = await http.post(
      Uri.parse('https://student.valuxapps.com/api/favorites'),
      headers: headers,
      body: jsonEncode({
        'product_id': productId,
      }),
    );

    if (response.statusCode == 200) {
      print('✅ Product added to Favorites successfully');
    } else {
      throw Exception(
        '❌ Failed to add product to Favorites. Status code: ${response.statusCode}, Response: ${response.body}',
      );
    }
  }

  Future<List<ProductModel>> getFavoritesItems({
    required BuildContext context,
  }) async {
    final headers = ApiConfig.getHeaders(context);

    http.Response response = await http.get(
      Uri.parse('https://student.valuxapps.com/api/favorites'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> FavoriteItems = jsonData['data']['data'];

      List<ProductModel> productList = [];
      for (var item in FavoriteItems) {
        productList.add(ProductModel.fromJson(item['product'] ?? {}));
      }
      return productList;
    } else {
      throw Exception(
        '❌ Failed to fetch Favorite items. Status code: ${response.statusCode}, Response: ${response.body}',
      );
    }
  }
}
