import 'package:flutter/cupertino.dart';

class SizeNumberModel with ChangeNotifier {
  int number;
  bool isFav = false;
  SizeNumberModel(this.number, {this.isFav});
}

class TabBarProvider with ChangeNotifier {
  List<SizeNumberModel> list = [];

  setTheList() {
    for (int i = 35; i <= 45; i++) {
      SizeNumberModel mySize = SizeNumberModel(i, isFav: false);
      list.add(mySize);
    }
  }

  markAsFavorite(int number) {
    for (int i = 0; i < 10; i++) {
      if (list[i].number == number) {
        list[i].isFav = true;
      } else {
        list[i].isFav = false;
      }
    }
    notifyListeners();
  }

  returnTheSize() {
    for (int i = 0; i < 10; i++) {
      if (list[i].isFav == true) return list[i].number;
    }
  }
}
