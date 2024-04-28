import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_admin_ar/core/manager/product_provider.dart';
import 'package:shopsmart_admin_ar/core/models/product_model.dart';
import 'package:shopsmart_admin_ar/core/services/app_assets.dart';
import 'package:shopsmart_admin_ar/core/widgets/app_name_shimmer.dart';
import 'package:shopsmart_admin_ar/core/widgets/empty_search_widget.dart';
import 'package:shopsmart_admin_ar/features/searchscreen/widgets/product_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static const routname = 'SearchScreen';
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productprovider = Provider.of<ProductProvider>(context);

    final String? CategoryName =
        ModalRoute.of(context)!.settings.arguments as String?;

    final List<ProductModel> products = CategoryName == null
        ? productprovider.getProducts()
        : productprovider.findproductsbycategory(category: CategoryName);

    List<ProductModel> productListSearch = [];

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: AppNameWidget(name: CategoryName ?? "Search Products"),
          centerTitle: true,
        ),
        body: StreamBuilder<List<ProductModel>>(
            stream:
                Provider.of<ProductProvider>(context).getProductsFromFirebase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text("there was an error..!"));
              } else if (snapshot.data == null) {
                return const NoProductsWidget();
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(IconlyLight.search),
                        suffixIcon: InkWell(
                          onTap: () {
                            _controller.clear();
                            FocusScope.of(context).unfocus();
                          },
                          child: const Icon(
                            Icons.clear,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          productListSearch =
                              productprovider.searchForProduct(product: value);
                        });
                      },
                      onSubmitted: (value) {
                        setState(() {
                          productListSearch =
                              productprovider.searchForProduct(product: value);
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (_controller.text.isNotEmpty &&
                        productListSearch.isEmpty) ...[
                      const Center(child: Text("No products found")),
                    ],
                    Expanded(
                      child: DynamicHeightGridView(
                        itemCount: _controller.text.isNotEmpty
                            ? productListSearch.length
                            : products.length,
                        builder: (context, index) {
                          return ChangeNotifierProvider.value(
                            value: products[index],
                            child: ProductItem(
                                productid: _controller.text.isNotEmpty
                                    ? productListSearch[index].productId
                                    : products[index].productId),
                          );
                        },
                        crossAxisCount: 2,
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
