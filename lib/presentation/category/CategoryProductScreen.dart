import 'package:eshop/core/models/ProductModel.dart';
import 'package:eshop/core/providers/ProductProvider.dart';
import 'package:eshop/core/providers/UserDataProvider.dart';
import 'package:eshop/presentation/home/Widget/ProductCard.dart';
import 'package:eshop/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryProductScreen extends StatelessWidget {
  CategoryProductScreen({super.key, required this.category});
  final String category;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "E-Shop",
            style: TextStyle(color: mainblue, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 18.0, right: 28),
              child: Row(
                children: [
                  Text("${category.toUpperCase()} PRODUCTS",
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Consumer2<UserDataProvider, ProductProvider>(builder:
                (BuildContext context, UserDataProvider userdataprovider,
                    ProductProvider productsprovider, Widget? child) {
              List<Product> product = [];

              if (!productsprovider.isLoading) {
                for (var i = 0;
                    i < productsprovider.productModel!.limit!;
                    i++) {
                  if (category ==
                      productsprovider.productModel!.products![i].category) {
                    product.add(productsprovider.productModel!.products![i]);
                  }
                }
              }
              return Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                    ),
                    itemCount: product.length,
                    itemBuilder: (context, i) {
                      return ProductCard(
                          product: product[i]);
                    }),
              );
            }),
          ],
        ),
      ),
    );
  }
}
