import 'package:Ecommerce/models/product.dart';
import 'package:Ecommerce/screens/toggle_screen.dart';
import 'package:Ecommerce/services/database_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [];
  List<Product> savedItems = [];
  // List<Product> getItems() {
  //   //get item because i use private item like this: _item And I use it private to handle it only from here so that I can call notifyListeners
  //   if (_showFavItems) {
  //     return [..._items]
  //         .where((element) => element.isFavorite == true)
  //         .toList();
  //   } else
  //     return [
  //       ..._items
  //     ]; // ... is a spread operator and here i'm using a refrence 'copy' From _items List
  // }
  List<Product> getItems(bool showFav) {
    if (showFav) {
      return [..._items]
          .where((element) => element.isFavorite == true)
          .toList();
    } else
      return [..._items];
  }

  fetchItems() async {
    QuerySnapshot snapshot = await DatabaseMethods().refProducts.get();
    List<Product> myList = [];
    snapshot.docs.forEach((element) async {
      String productId = element.id;
      bool state = await DatabaseMethods().checkState(userId, productId);
      Product myProduct = Product(
          desc: element['desc'],
          imageUrl: element['imageUrl'],
          price: element['price'].toDouble(),
          isFavorite: state,
          id: element['id'],
          title: element['title']);
      myList.add(myProduct);
    });
    _items = myList;
    notifyListeners();
  }

  addProduct(String title, String desc, double price, String imageUrl,
      String id) async {
    Product product = Product(
        id: id,
        desc: desc,
        imageUrl: imageUrl,
        price: price,
        title: title,
        isFavorite: false);
    _items.add(product);
    await DatabaseMethods().addProduct(product);
  }

  removeProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
    DatabaseMethods().removeProduct(id);
  }

  searchForProduct(String title) {
    List<Product> searchedProducts = [];
    for (int i = 0; i < _items.length; i++) {
      if (_items[i].title.toLowerCase().contains(title.toLowerCase())) {
        searchedProducts.add(_items[i]);
      }
    }
    return searchedProducts;
    // _items = serachedProducts;
    // notifyListeners();
  }
}
