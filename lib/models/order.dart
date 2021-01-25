import 'package:Ecommerce/models/cart.dart';

class Order {
  String id;
  double amount;
  List<Cart> listOfProducts;
  DateTime dateTime;
  Order({this.id, this.amount, this.dateTime, this.listOfProducts});
}
