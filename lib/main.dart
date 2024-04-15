import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_admin_ar/core/manager/product_provider.dart';
import 'package:shopsmart_admin_ar/core/utils/themedata/ThemData.dart';
import 'package:shopsmart_admin_ar/core/utils/themedata/manager/themeData_provider.dart';
import 'package:shopsmart_admin_ar/features/add_product_screen/add_product_screen.dart';
import 'package:shopsmart_admin_ar/features/dashboardscreen/presentation/views/dashboard_screen.dart';
import 'package:shopsmart_admin_ar/firebase_options.dart';
import 'features/ordersscreen/orders_screen.dart';
import 'features/searchscreen/search_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
      ],
      child: Consumer<ThemeDataProvider>(builder: (
        context,
        themeProvider,
        child,
      ) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shop Smart ADMIN',
          theme: Themedata.themedata(
              isDark: themeProvider.isDarkTheme(), context: context),
          home: const DashboardScreen(),
          routes: {
            OrdersScreenFree.routeName: (context) => const OrdersScreenFree(),
            SearchScreen.routname: (context) => const SearchScreen(),
            AddOrUpdateProductScreen.routname: (context) =>
                const AddOrUpdateProductScreen(),
          },
        );
      }),
    );
  }
}
