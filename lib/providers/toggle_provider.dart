import 'package:flutter/material.dart';

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
    xOffset = 230;
    yOffset = 160;
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
