import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool getTheme() => _isDarkMode;

  void changeTheme({required bool value}) {
    _isDarkMode = value;
    notifyListeners();
  }
}
