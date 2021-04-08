import 'package:Ecommerce/constatns.dart';
import 'package:Ecommerce/models/order.dart';
import 'package:Ecommerce/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class OrderItem extends StatelessWidget {
  final Order order;
  OrderItem(this.order);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.0.w),
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          //  duration: Duration(microseconds: 200),
          height: 40.0.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0.sp),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 0,
                offset: Offset(0.5, .5), //(x,y)
                blurRadius: 20.0,
              ),
            ],
          ),
          child: Consumer<OrderProvider>(
            builder: (context, provider, child) {
              return Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'ORDER : ${order.dateTime}',
                      style: myUpuntoFont(
                          Colors.grey[400], 12.0.sp, FontWeight.w300),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      child: Text(
                        '\$${order.amount}',
                        style:
                            myUpuntoFont(darkColor, 18.0.sp, FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Image.network(
                            order.listOfProducts[0].myProduct.imageUrl,
                            height: 15.5.h,
                          ),
                          Container(
                            color: Colors.grey[100],
                            child: Text(
                              order.listOfProducts[0].myProduct.title,
                              style: myUpuntoFont(
                                  yellowColor, 11.5.sp, FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
