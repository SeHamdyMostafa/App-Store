import 'package:appstore/Screens/FavoritesPage.dart';
import 'package:appstore/Screens/Home_Page/Center/ListOfAllItems.dart';
import 'package:appstore/Screens/Home_Page/Header/CategoriesList.dart';
import 'package:appstore/helper/DeviceDimenssions.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String searchQuery = '';
  bool isSearching = false;
  Widget currentPage = CategoriesList();
  bool showAllProducts = false;

  void updatePage(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        isSearching = false;
        currentPage = CategoriesList();
      } else {
        isSearching = true;
        currentPage = ListOfAllItems(searchQuery: query);
      }
    });
  }

  Future<void> fetchAllProducts() async {
    setState(() {
      isSearching = true;
      currentPage = ListOfAllItems(searchQuery: '');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              SafeArea(
                child: PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight + 10),
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              isSearching ? 'Search Results' : 'Categories',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextField(
                                  onTap: () async {
                                    await fetchAllProducts();
                                  },
                                  onChanged: (value) {
                                    updatePage(value);
                                  },
                                  
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                                    hintText: 'Search...',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                                  ),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.favorite, color: Colors.red, size: 34),
                            onPressed: (
                              
                            ) {
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return FavoritesPage();
                              }));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned.fill(
            top: DeviceDimensions.deviceHeight * 0.13,
            child: currentPage,
          ),
        ],
      ),
    );
  }
}
