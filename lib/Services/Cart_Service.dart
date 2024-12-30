import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:appstore/helper/api_config.dart';
import 'package:appstore/Model/Product_Model.dart';

class CartService {
  // إضافة منتج إلى السلة
  Future<void> addToCart({
    required int productId,
    required BuildContext context,
  }) async {
    final headers = ApiConfig.getHeaders(context);

    http.Response response = await http.post(
      Uri.parse('https://student.valuxapps.com/api/carts'),
      headers: headers,
      body: jsonEncode({
        'product_id': productId,
      }),
    );

    if (response.statusCode == 200) {
      print('✅ Product added to cart successfully');
    } else {
      throw Exception(
        '❌ Failed to add product to cart. Status code: ${response.statusCode}, Response: ${response.body}',
      );
    }
  }

  // جلب عناصر السلة
  Future<List<ProductModel>> getCartItems({
    required BuildContext context,
  }) async {
    final headers = ApiConfig.getHeaders(context);

    http.Response response = await http.get(
      Uri.parse('https://student.valuxapps.com/api/carts'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      List<dynamic> cartItems = jsonData['data']['cart_items'];

      List<ProductModel> productList = [];
      for (var item in cartItems) {
        productList.add(ProductModel.fromJson({
          ...item['product'],
          'quantity': item['quantity'],
          'cartItemId':item['id']
        }));
      }
      return productList;
    } else {
      throw Exception(
        '❌ Failed to fetch cart items. Status code: ${response.statusCode}, Response: ${response.body}',
      );
    }
  }

  // تحديث الكمية في السلة
  Future<void> updateCartItemQuantity({
    required int cartItemId,
    required int quantity,
    required BuildContext context,
  }) async {
    final headers = ApiConfig.getHeaders(context);

    http.Response response = await http.put(
      Uri.parse('https://student.valuxapps.com/api/carts/$cartItemId'),
      headers: headers,
      body: jsonEncode({
        'quantity': quantity,
      }),
    );

    if (response.statusCode == 200) {
      print('✅ Quantity updated successfully');
      print('cartItemId${cartItemId}');
    } else {
      throw Exception(
        '❌ Failed to update quantity. Status code: ${response.statusCode}, Response: ${response.body}',
      );
    }
  }

  // التحقق من وجود المنتج في السلة
  Future<bool> isProductInCart({
    required int productId,
    required BuildContext context,
  }) async {
    try {
      final cartItems = await getCartItems(context: context);

      // تحقق مما إذا كان المنتج في السلة
      return cartItems.any((item) => item.productId == productId);
    } catch (e) {
      print("❌ Error checking if product is in cart: $e");
      return false;  // في حالة حدوث خطأ، يتم إرجاع false
    }
  }
}
