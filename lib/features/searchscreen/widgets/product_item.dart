import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_admin_ar/core/manager/product_provider.dart';
import 'package:shopsmart_admin_ar/core/models/product_model.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.productid,
  });
  final String productid;
  @override
  Widget build(BuildContext context) {
    final productprovider = Provider.of<ProductProvider>(context);
    ProductModel? model = productprovider.findProductbyId(id: productid);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {},
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FancyShimmerImage(
                imageUrl: model!.productImage,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.22,
                errorWidget: const Icon(Icons.error),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    model.productTitle,
                    style: const TextStyle(fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              model.productPrice,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
