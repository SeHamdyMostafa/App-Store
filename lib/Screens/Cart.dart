import 'package:appstore/Model/Product_Model.dart';
import 'package:flutter/material.dart';
import 'package:appstore/Services/Cart_Service.dart';
import 'package:appstore/Widget/ModelCardItem/ModelCardItem.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<ProductModel>> futureCartItems;

  @override
  void initState() {
    super.initState();
    futureCartItems = CartService().getCartItems(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('🛒 Cart')),
      body: FutureBuilder<List<ProductModel>>(
        future: futureCartItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('❌ Error: ${snapshot.error}'));
          } else {
            final cartItems = snapshot.data!;
            if (cartItems.isEmpty) {
              return Center(child: Text('🛒 The cart is empty.'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(5),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final product = cartItems[index];
                return ModelCardItem(
                  productModel: product,
                  isCartPage: true
                );
              },
            );
          }
        },
      ),
    );
  }
}
