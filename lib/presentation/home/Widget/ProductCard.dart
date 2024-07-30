import 'package:eshop/core/models/ProductModel.dart';
import 'package:eshop/core/providers/PriceProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PriceProvider>(builder:
        (BuildContext context, PriceProvider userdataprovider, Widget? child) {
      bool showdiscountPercentage =
          context.watch<PriceProvider>().showDiscountedPrice;

      return Card(
        margin: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.images![0],
                height: 150, width: double.infinity, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(product.title ?? "",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(product.description ?? "",
                  maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('\$${product.price}',
                      style: TextStyle(
                          fontSize: 14,
                          color: showdiscountPercentage
                              ? Colors.grey
                              : Colors.black,
                          decoration: showdiscountPercentage
                              ? TextDecoration.lineThrough
                              : TextDecoration.none)),
                  SizedBox(width: 8),
                  showdiscountPercentage
                      ? Row(
                          children: [
                            Text(
                                '\$${(product.price! - ((product.price! * product.discountPercentage!) / 100)).toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                            SizedBox(width: 8),
                            Text(
                                '${product.discountPercentage ?? 0.toStringAsFixed(2)}% off',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.green)),
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
