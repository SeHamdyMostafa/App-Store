import 'package:appstore/Model/Product_Model.dart';
import 'package:appstore/Services/Search_Service.dart';
import 'package:appstore/Widget/ModelCardItem/ModelCardItem.dart';
import 'package:flutter/material.dart';
class ListOfAllItems extends StatefulWidget {
  final String searchQuery;

  ListOfAllItems({required this.searchQuery});

  @override
  State<ListOfAllItems> createState() => _ListOfAllItemsState();
}

class _ListOfAllItemsState extends State<ListOfAllItems> {
  late Future<List<ProductModel>> futureProducts;

  @override
  void initState() {
    super.initState();
    if (widget.searchQuery.isEmpty) {
      futureProducts = SearchService().getAllProducts(context: context);
    } else {
      futureProducts = SearchService().searchProduct(query: widget.searchQuery, context: context);
    }
  }

  @override
  void didUpdateWidget(covariant ListOfAllItems oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery) {
      setState(() {
        if (widget.searchQuery.isEmpty) {
          futureProducts = SearchService().getAllProducts(context: context);
        } else {
          futureProducts = SearchService().searchProduct(query: widget.searchQuery, context: context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: futureProducts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<ProductModel> products = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
              childAspectRatio: 5 / 2,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ModelCardItem(productModel: products[index],isCartPage: false);
            },
          );
        }
      },
    );
  }
}
