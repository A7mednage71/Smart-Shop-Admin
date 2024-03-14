import 'package:flutter/material.dart';
import 'package:shopsmart_admin_ar/core/services/app_assets.dart';

class NoProductsWidget extends StatelessWidget {
  const NoProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.asset(
              Appassets.emptySearch,
              height: 300,
              width: 200,
            ),
            const Text(
              "there is no products added Yet",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
