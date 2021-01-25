import 'package:Ecommerce/constatns.dart';
import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 400,
          decoration: BoxDecoration(
              color: yellowColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(400),
                  bottomRight: Radius.circular(400))),
          child: Text(
            'No items in your cart!',
            textAlign: TextAlign.center,
            style: myUpuntoFont(darkColor, 35, FontWeight.w600),
          ),
        ),
        Image(
          image: AssetImage('images/empty-cart.png'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
          child: Text(
            'Add some products to your cart and try agian',
            textAlign: TextAlign.center,
            style: myUpuntoFont(darkColor, 20, FontWeight.w300),
          ),
        )
      ],
    );
  }
}
