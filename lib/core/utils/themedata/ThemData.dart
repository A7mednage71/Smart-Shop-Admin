import 'package:flutter/material.dart';
import 'package:shopsmart_admin_ar/core/utils/themedata/App_colors.dart';

class Themedata {
  static themedata({required bool isDark, required BuildContext context}) {
    return ThemeData(
      scaffoldBackgroundColor:
          isDark ? AppColor.darkScaffoldColor : AppColor.lightScaffoldcolor,
      cardColor: isDark ? AppColor.darkScaffoldColor : AppColor.lightCardColor,
      brightness: isDark ? Brightness.dark : Brightness.light,
      appBarTheme: AppBarTheme(
        backgroundColor:
            isDark ? AppColor.darkScaffoldColor : AppColor.lightScaffoldcolor,
        elevation: 0,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
      ),
      iconTheme: IconThemeData(
          color: isDark ? AppColor.lightCardColor : AppColor.darkCardColor),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        contentPadding: const EdgeInsets.all(10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(width: 2, color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
              BorderSide(width: 2, color: isDark ? Colors.white : Colors.black),
        ),
      ),
      primaryColor: isDark
          ? const Color.fromARGB(255, 218, 54, 202)
          : const Color(0xffE2E0FF),
      // textTheme: GoogleFonts.redHatTextTextTheme(),
    );
  }
}
