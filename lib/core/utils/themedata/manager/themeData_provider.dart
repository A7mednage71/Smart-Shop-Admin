import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeDataProvider with ChangeNotifier {
  ThemeDataProvider() {
    getTHeme();
  }

  bool darkTheme = false;
  static const theme = 'THEME_APP';

  bool isDarkTheme() => darkTheme;

  Future<void> settheme({required bool themevalue}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(theme, themevalue);
    darkTheme = themevalue;
    notifyListeners();
  }

  Future<bool> getTHeme() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    darkTheme = pref.getBool(theme) ?? false;
    notifyListeners();
    return darkTheme;
  }
}
