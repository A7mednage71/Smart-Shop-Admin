import 'package:flutter/material.dart';
import 'package:shopsmart_admin_ar/core/services/app_assets.dart';
import 'package:shopsmart_admin_ar/core/widgets/app_name_shimmer.dart';
import 'package:shopsmart_admin_ar/core/widgets/custom_empty_data.dart';
import 'widgets/orders_widget.dart';

class OrdersScreenFree extends StatefulWidget {
  static const routeName = '/OrderScreen';

  const OrdersScreenFree({Key? key}) : super(key: key);

  @override
  State<OrdersScreenFree> createState() => _OrdersScreenFreeState();
}

class _OrdersScreenFreeState extends State<OrdersScreenFree> {
  bool isEmptyOrders = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const AppNameWidget(name: "OrdersScreen"),
        ),
        body: isEmptyOrders
            ? CustomEmptyDataWidget(
                image: Appassets.order,
                title: "No orders has been placed yet",
                subtitle: "",
                buttomtext: '',
              )
            : ListView.separated(
                itemCount: 15,
                itemBuilder: (ctx, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                    child: OrdersWidgetFree(),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              ));
  }
}
