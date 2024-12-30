import 'package:appstore/Model/category_model.dart';
import 'package:appstore/Screens/Home_Page/Center/ListOfProductsCatogry.dart';
import 'package:appstore/Services/All_Category_Service.dart';
import 'package:appstore/Widget/CardCategory.dart';
import 'package:appstore/helper/DeviceDimenssions.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatefulWidget {
  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  late Future<List<CategoryModel>> _categoriesFuture;
  int? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = AllCategoryService().getCategories(context);
  }

  void _selectCategory(int categoryId) {
    setState(() {
      selectedCategoryId = categoryId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryModel>>(
      future: _categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No categories available'));
        }

        final categories = snapshot.data!;
        selectedCategoryId ??= categories.first.id;

        return NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: SizedBox(
                height: DeviceDimensions.deviceHeight * .26,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CategoryCard(
                        name: categories[index].name,
                        imageUrl: categories[index].imageUrl,
                        onTap: () {
                          _selectCategory(categories[index].id);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
          body: ListOfProductsCatogry(categoryId: selectedCategoryId!),
        );
      },
    );
  }
}
