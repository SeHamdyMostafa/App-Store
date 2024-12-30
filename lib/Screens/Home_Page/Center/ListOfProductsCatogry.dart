import 'package:flutter/material.dart';
import 'package:appstore/Model/Product_Model.dart';
import 'package:appstore/Services/Products_Of_Category_Srevice.dart';
import 'package:appstore/Widget/ProductCard/CardItemOfProduct.dart';

class ListOfProductsCatogry extends StatelessWidget {
  final int categoryId;

  ListOfProductsCatogry({required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: ProductsOfCategoryService()
          .getProductsOfCategory(categoryId: categoryId, context: context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No products found.'));
        } else {
          List<ProductModel> products = snapshot.data!;

          return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              childAspectRatio: 1 / 2,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return CardItemOfProduct(productModel: products[index]);
            },
          );
        }
      },
    );
  }
}
