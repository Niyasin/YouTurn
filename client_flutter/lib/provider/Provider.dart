import 'package:flutter/material.dart';

bool _isLoggedIn = false;

class TagProvider_1 with ChangeNotifier {
  bool get getIsLoggedIn => _isLoggedIn;

  void changeDp()
  {

  }

  void changeLogin() {
    if (_isLoggedIn == true) {
      _isLoggedIn = false;
    } else {
      _isLoggedIn = true;
    }
  }
}