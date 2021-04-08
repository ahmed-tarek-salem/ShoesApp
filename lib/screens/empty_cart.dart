import 'package:Ecommerce/constatns.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 15.0.h,
          width: 100.0.w,
          decoration: BoxDecoration(
              color: yellowColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(400),
                  bottomRight: Radius.circular(400))),
          child: Text(
            'No items in your cart!',
            textAlign: TextAlign.center,
            style: myUpuntoFont(darkColor, 27.0.sp, FontWeight.w600),
          ),
        ),
        Image(
          image: AssetImage('images/empty-cart.png'),
          height: 50.0.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 5.0.w),
          child: Text(
            'Add some products to your cart and try agian',
            textAlign: TextAlign.center,
            style: myUpuntoFont(darkColor, 15.0.sp, FontWeight.w300),
          ),
        )
      ],
    );
  }
}
