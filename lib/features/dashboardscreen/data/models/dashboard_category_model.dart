import 'package:flutter/material.dart';
import 'package:shopsmart_admin_ar/core/services/app_assets.dart';
import 'package:shopsmart_admin_ar/features/ordersscreen/orders_screen.dart';
import 'package:shopsmart_admin_ar/features/searchscreen/search_screen.dart';

class DashboardCategoryModel {
  final String image, title;
  final void Function() onpress;

  DashboardCategoryModel({
    required this.image,
    required this.title,
    required this.onpress,
  });

  static List<DashboardCategoryModel> dashboardCategory(BuildContext context) =>
      [
        DashboardCategoryModel(
          image: Appassets.cloud,
          title: "Add New Product",
          onpress: () {
            // Navigator.of(context).pushNamed();
          },
        ),
        DashboardCategoryModel(
            image: Appassets.shoppingCart,
            title: "Inspect All Products",
            onpress: () {
              Navigator.of(context).pushNamed(SearchScreen.routname);
            }),
        DashboardCategoryModel(
          image: Appassets.order,
          title: "View Orders",
          onpress: () {
            Navigator.of(context).pushNamed(OrdersScreenFree.routeName);
          },
        ),
      ];
}
