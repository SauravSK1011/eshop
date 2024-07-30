import 'package:eshop/core/providers/ProductProvider.dart';
import 'package:eshop/core/providers/UserDataProvider.dart';
import 'package:eshop/presentation/home/Widget/ProductCard.dart';
import 'package:eshop/utils/constants.dart';
import 'package:eshop/widgets/mybottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categories = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Consumer2<UserDataProvider, ProductProvider>(
          builder: (BuildContext context, UserDataProvider userdataprovider,
              ProductProvider productsprovider, Widget? child) {
            final productModel = productsprovider.productModel;

            if (productModel != null && !productsprovider.isLoading) {
              for (var i = 0; i < productsprovider.productModel!.limit!; i++) {
                if (!categories.contains(
                    productsprovider.productModel!.products![i].category)) {
                  categories.add(productsprovider
                      .productModel!.products![i].category
                      .toString());
                }
              }
            }
            print(categories.length);
            return (!productsprovider.isLoading && productModel != null)
                ? Scaffold(
                    backgroundColor: Colors.black.withOpacity(0.2),
                    appBar: AppBar(
                      title: Text(
                        "Home",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    ),
                    body: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Card(
                              child: Card(
                                elevation: 50,
                                color: mainblue,
                                child: Container(
                                  height: size.height / 4,
                                  width: size.width,
                                  child: const Center(
                                    child: Text(
                                      "E-Shop",
                                      style: TextStyle(
                                          fontSize: 50,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height / 32,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 18.0, right: 28),
                              child: Row(
                                children: [
                                  Text("Top Products",
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Container(
                              height: size.height * 2,
                              child: GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.6,
                                  ),
                                  itemCount: 10,
                                  itemBuilder: (context, i) {
                                    return ProductCard(
                                        product: productsprovider
                                            .productModel!.products![i]);
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
        bottomNavigationBar: MybottomNavigationBar());
  }
}
