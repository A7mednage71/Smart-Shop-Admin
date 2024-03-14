import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_admin_ar/core/services/app_assets.dart';
import 'package:shopsmart_admin_ar/core/utils/themedata/manager/themeData_provider.dart';
import 'package:shopsmart_admin_ar/core/widgets/app_name_shimmer.dart';
import 'package:shopsmart_admin_ar/features/dashboardscreen/data/models/dashboard_category_model.dart';
import 'package:shopsmart_admin_ar/features/dashboardscreen/presentation/views/widgets/dashboard_item.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/DashboardScreen';
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeDataProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const AppNameWidget(
          name: 'Dashboard Screen',
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(Appassets.shoppingCart),
        ),
        actions: [
          IconButton(
            onPressed: () {
              themeProvider.settheme(themevalue: !themeProvider.isDarkTheme());
            },
            icon: Icon(themeProvider.isDarkTheme()
                ? Icons.light_mode
                : Icons.dark_mode),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: 3,
          itemBuilder: (context, index) {
            return DashboardItem(
              image: DashboardCategoryModel.dashboardCategory(context)[index]
                  .image,
              text: DashboardCategoryModel.dashboardCategory(context)[index]
                  .title,
              onTap: DashboardCategoryModel.dashboardCategory(context)[index]
                  .onpress,
            );
          },
        ),
      ),
    );
  }
}
