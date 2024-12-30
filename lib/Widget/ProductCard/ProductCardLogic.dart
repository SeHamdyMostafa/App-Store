import 'package:flutter/material.dart';
import 'package:appstore/Services/Cart_Service.dart';
import 'package:appstore/Services/Favorites_Service.dart';
import 'package:appstore/Model/Product_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductCardLogic {
  final ProductModel productModel;
  bool isFavorited = false;

  ProductCardLogic({required this.productModel});

  Future<void> loadFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFavorited = prefs.getBool('favorite_${productModel.productId}') ?? false;
  }

  Future<void> toggleFavorite(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFavorited = !isFavorited;
    prefs.setBool('favorite_${productModel.productId}', isFavorited);

    await FavoritesService().addToFavorites(
      productId: productModel.productId,
      context: context,
    );
  }

  Future<void> addToCart(BuildContext context) async {
    try {
      showLoadingDialog(context);

      bool isInCart = await CartService().isProductInCart(
        productId: productModel.productId,
        context: context,
      );

      if (isInCart) {
        List<ProductModel> cartItems = await CartService().getCartItems(context: context);
        ProductModel product = cartItems.firstWhere((item) => item.productId == productModel.productId);
        int updatedQuantity = product.quantity + 1;

        await CartService().updateCartItemQuantity(
          cartItemId: product.cartItemId,
          quantity: updatedQuantity,
          context: context,
        );

        Navigator.of(context).pop();  

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('✔️ Quantity updated in cart!')),
        );
      } else {
        await CartService().addToCart(
          productId: productModel.productId,
          context: context,
        );

        Navigator.of(context).pop(); 
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('✔️ Product added to cart!')),
        );
      }
    } catch (e) {
      Navigator.of(context).pop();  

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Error: ${e.toString()}')),
      );
    }
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Updating cart..."),
            ],
          ),
        );
      },
    );
  }
}
