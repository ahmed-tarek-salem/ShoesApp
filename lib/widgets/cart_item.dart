import 'package:Ecommerce/constatns.dart';
import 'package:Ecommerce/models/cart.dart';
import 'package:Ecommerce/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

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
        margin: EdgeInsets.symmetric(vertical: 2.4.h),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Icon(Icons.delete, size: 38.5.sp, color: Colors.white),
      ),
      onDismissed: (_) async {
        final cartProvider = Provider.of<CartProvider>(context, listen: false);
        await cartProvider.removeItem(cart.myProduct.id);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.5.h),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 22.0.h,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.network(
                  cart.myProduct.imageUrl,
                ),
              ),
            ),
            SizedBox(width: 5.0.w),
            Expanded(
              flex: 3,
              child: Container(
                height: 19.0.h,
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
                            style: myUpuntoFont(
                                darkColor, 11.5.sp, FontWeight.w700,
                                letterSpacing: -1),
                          ),
                        ),
                        SizedBox(height: 1.5.h),
                        Text(
                          '\$ ${cart.myProduct.price}',
                          style: myUpuntoFont(
                              darkColor, 14.0.sp, FontWeight.w400,
                              letterSpacing: -1),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        cart.size == null
                            ? Container()
                            : Padding(
                                padding: EdgeInsets.only(right: 2.0.w),
                                child: CircleAvatar(
                                  radius: 17.0.sp,
                                  backgroundColor: darkColor,
                                  child: Text(
                                    '${cart.size}',
                                    style: myGoogleFont(
                                        Colors.white, 13.0.sp, FontWeight.w500),
                                  ),
                                ),
                              ),
                        CircleAvatar(
                          radius: 17.0.sp,
                          backgroundColor: Colors.grey[100],
                          child: Text(
                            'x${cart.quantity}',
                            style: myGoogleFont(
                                darkColor, 13.0.sp, FontWeight.w500),
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
