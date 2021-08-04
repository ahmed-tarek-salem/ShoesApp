import 'package:Ecommerce/models/product.dart';

class Cart {
  final Product myProduct;
  final int size;
  final int quantity;

  const Cart({this.myProduct, this.size, this.quantity});
}
