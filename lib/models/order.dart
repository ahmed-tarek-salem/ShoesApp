import 'package:Ecommerce/models/cart.dart';

class Order {
  final String id;
  final double amount;
  final List<Cart> listOfProducts;
  final DateTime dateTime;
  const Order({this.id, this.amount, this.dateTime, this.listOfProducts});
}
