import 'package:eshop/core/providers/ProductProvider.dart';
import 'package:eshop/core/providers/UserDataProvider.dart';
import 'package:eshop/presentation/category/CategoryProductScreen.dart';
import 'package:eshop/utils/constants.dart';
import 'package:eshop/widgets/mybottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> categories = [];

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Category",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 30),
          ),
        ),
        body: Consumer2<UserDataProvider, ProductProvider>(builder:
            (BuildContext context, UserDataProvider userdataprovider,
                ProductProvider productsprovider, Widget? child) {
          if (!productsprovider.isLoading) {
            for (var i = 0; i < productsprovider.productModel!.limit!; i++) {
              if (!categories.contains(
                  productsprovider.productModel!.products![i].category)) {
                categories.add(productsprovider
                    .productModel!.products![i].category
                    .toString());
              }
            }
          }

          return (!productsprovider.isLoading)
              ? Container(
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, i) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CategoryProductScreen(
                                    category: categories[i])));
                          },
                          child: Card(
                              elevation: 50,
                              child: Center(
                                  child: Text(categories[i].toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)))),
                        );
                      }),
                )
              : Center(child: CircularProgressIndicator());
        }),
        bottomNavigationBar: MybottomNavigationBar(
          index: 1,
        ));
  }
}
