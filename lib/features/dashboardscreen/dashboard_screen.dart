import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_admin_ar/core/services/app_assets.dart';
import 'package:shopsmart_admin_ar/core/utils/themedata/manager/themeData_provider.dart';
import 'package:shopsmart_admin_ar/core/widgets/title_text.dart';

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
        title: const TitlesTextWidget(label: "Dashboard Screen"),
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
      body: const Center(
        child: TitlesTextWidget(label: "Dashboard Screen"),
      ),
    );
  }
}
