import 'package:Ecommerce/constatns.dart';
import 'package:Ecommerce/models/cart.dart';
import 'package:Ecommerce/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final Cart cart;
  CartItem(this.cart);
  returnShowDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('An error occured'),
            content: Text('Something went wrong'),
            actions: [
              FlatButton(
                child: Text('ok'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cart.myProduct.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Icon(Icons.delete, size: 50, color: Colors.white),
      ),
      onDismissed: (_) async {
        final cartProvider = Provider.of<CartProvider>(context, listen: false);
        await cartProvider.removeItem(cart.myProduct.id);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.network(
                  cart.myProduct.imageUrl,
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              flex: 3,
              child: Container(
                height: 120,
                // width: 180,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            cart.myProduct.title,
                            overflow: TextOverflow.ellipsis,
                            style: myUpuntoFont(darkColor, 15, FontWeight.w700,
                                letterSpacing: -1),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '\$ ${cart.myProduct.price}',
                          style: myUpuntoFont(darkColor, 18, FontWeight.w400,
                              letterSpacing: -1),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        cart.size == null
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: CircleAvatar(
                                  radius: 22,
                                  backgroundColor: darkColor,
                                  child: Text(
                                    '${cart.size}',
                                    style: myGoogleFont(
                                        Colors.white, 17, FontWeight.w500),
                                  ),
                                ),
                              ),
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.grey[100],
                          child: Text(
                            'x${cart.quantity}',
                            style: myGoogleFont(darkColor, 17, FontWeight.w500),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
