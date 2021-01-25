import 'package:Ecommerce/models/cart.dart';
import 'package:Ecommerce/models/order.dart';
import 'package:Ecommerce/services/database_methods.dart';
import 'package:flutter/cupertino.dart';

class OrderProvider with ChangeNotifier {
  List<Order> orders = [];

  addOrder(List<Cart> cartProducts, double total) async {
    final timeStamp = DateTime.now();
    Order order = Order(
        id: timeStamp.toIso8601String(),
        amount: total,
        dateTime: timeStamp,
        listOfProducts: cartProducts);
    await DatabaseMethods().addOrder(order);
    orders.add(order);
    notifyListeners();
  }

  fetchOrders() async {
    orders = await DatabaseMethods().fetchOrders();
    notifyListeners();
  }
}
