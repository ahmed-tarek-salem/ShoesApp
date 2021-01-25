import 'package:Ecommerce/models/cart.dart';
import 'package:Ecommerce/models/product.dart';
import 'package:Ecommerce/services/database_methods.dart';
import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
  Map<String, Cart> items = {};
  Map<String, Cart> savedItems = {};

  getItems() {
    return items;
  }

  double getPrice() {
    double numberOfProducts = 0;
    for (int i = 0; i < items.length; i++) {
      numberOfProducts += (items.values.toList()[i].quantity *
          items.values.toList()[i].myProduct.price);
    }
    return numberOfProducts;
  }

  int getCount() {
    int numberOfProducts = 0;
    for (int i = 0; i < items.length; i++) {
      numberOfProducts += items.values.toList()[i].quantity;
    }
    return numberOfProducts;
  }

  fetchCarts() async {
    DatabaseMethods databaseMethods = DatabaseMethods();
    items = await databaseMethods.fetchCartData();
    notifyListeners();
  }

  addItem(Product product, int size) async {
    DatabaseMethods databaseMethods = DatabaseMethods();
    Cart updatedCart;
    if (items.containsKey(product.id)) {
      items.update(product.id, (existingValue) {
        // updatedQuantity = existingValue.quantity + 1;
        Cart cart = Cart(
            myProduct: existingValue.myProduct,
            quantity: existingValue.quantity + 1,
            size: size);
        updatedCart = cart;
        return updatedCart;
      });
      await databaseMethods.adddCartItem(updatedCart, true);
    } else {
      items.putIfAbsent(
        product.id,
        () {
          Cart cart = Cart(myProduct: product, quantity: 1, size: size);
          updatedCart = cart;
          return updatedCart;
        },
      );
      await databaseMethods.adddCartItem(updatedCart, false);
    }
    notifyListeners();
  }

  removeItem(String cartId) async {
    await DatabaseMethods().removeSingleCartItem(cartId);
    items.removeWhere((key, value) => key == cartId);
    notifyListeners();
  }

  removeAllItems() async {
    await DatabaseMethods().removeAllCartItems();
    items.clear();
    notifyListeners();
  }

  saveItems() {
    savedItems = items;
    notifyListeners();
  }

  returnSaved() {
    items = savedItems;
    notifyListeners();
  }

  searchForWord(String word) {
    Map<String, Cart> newItems = {};
    // items.containsValue(regExp.hasMatch(items.values.toList()[i].myProduct.title));
    for (int i = 0; i < items.length; i++) {
      if (items.values
          .toList()[i]
          .myProduct
          .title
          .toLowerCase()
          .contains(word.toLowerCase()))
        newItems.putIfAbsent(items.values.toList()[i].myProduct.id,
            () => items.values.toList()[i]);
    }
    items = newItems;
    notifyListeners();
  }
}
