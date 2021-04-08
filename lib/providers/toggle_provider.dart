import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ToggleProvider with ChangeNotifier {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  changeToZero() {
    xOffset = 0;
    yOffset = 0;
    scaleFactor = 1;
    isDrawerOpen = false;
    notifyListeners();
  }

  changeToValues() {
    xOffset = 56.0.w;
    yOffset = 25.0.h;
    scaleFactor = 0.6;
    isDrawerOpen = true;
    notifyListeners();
  }

  removeHome() {
    xOffset = 500;
    yOffset = 500;
    scaleFactor = 0.6;
    isDrawerOpen = true;
    notifyListeners();
  }
}
