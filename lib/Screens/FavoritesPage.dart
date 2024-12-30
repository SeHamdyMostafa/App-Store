import 'package:appstore/Services/Favorites_Service.dart';
import 'package:flutter/material.dart';
import 'package:appstore/Widget/ModelCardItem/ModelCardItem.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late Future<List<dynamic>> futureFavoriteItems;

  @override
  void initState() {
    super.initState();
    futureFavoriteItems =
        FavoritesService().getFavoritesItems(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('❤️ Favorites'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: futureFavoriteItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('❌ Error: ${snapshot.error}'));
          } else {
            final favoriteItems = snapshot.data!;
            if (favoriteItems.isEmpty) {
              return Center(
                  child: Text('❤️ Your favorites list is empty.'));
            }
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
                childAspectRatio: 5 / 2,
              ),
              itemCount: favoriteItems.length,
              itemBuilder: (context, index) {
                return ModelCardItem(
                  productModel: favoriteItems[index],
                  isCartPage: false, // بدون أزرار
                );
              },
            );
          }
        },
      ),
    );
  }
}
