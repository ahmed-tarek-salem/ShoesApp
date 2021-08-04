import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  final String title;
  final String desc;
  final String imageUrl;
  final String id;
  final double price;
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
