import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  String title;
  String desc;
  String imageUrl;
  String id;
  double price;
  bool isFavorite;

  Product(
      {this.title,
      this.desc,
      this.imageUrl,
      this.price,
      this.isFavorite,
      this.id});

  toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
