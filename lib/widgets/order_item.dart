import 'package:Ecommerce/constatns.dart';
import 'package:Ecommerce/models/order.dart';
import 'package:Ecommerce/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderItem extends StatelessWidget {
  final Order order;
  OrderItem(this.order);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          //  duration: Duration(microseconds: 200),
          height: 230,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
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
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'ORDER : ${order.dateTime}',
                      style:
                          myUpuntoFont(Colors.grey[400], 16, FontWeight.w300),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        '\$${order.amount}',
                        style: myUpuntoFont(darkColor, 23, FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Image.network(
                            order.listOfProducts[0].myProduct.imageUrl,
                            height: 100,
                          ),
                          Container(
                            color: Colors.grey[100],
                            child: Text(
                              order.listOfProducts[0].myProduct.title,
                              style: myUpuntoFont(
                                  yellowColor, 15, FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    )

                    // Expanded(
                    //     child: GridView.builder(
                    //         padding: const EdgeInsets.all(10),
                    // itemCount: order.listOfProducts.length <= 3
                    //     ? order.listOfProducts.length
                    //     : 3,
                    //         itemBuilder: (context, index) {
                    //           return Column(
                    //             children: [
                    //               Image.network(
                    //                 order.listOfProducts[index].myProduct
                    //                     .imageUrl,
                    //                 //height: 50,
                    //               ),
                    //               Text(order
                    //                   .listOfProducts[index].myProduct.title)
                    //             ],
                    //           );
                    //         },
                    //         gridDelegate:
                    //             SliverGridDelegateWithFixedCrossAxisCount(
                    //           crossAxisCount: 3,
                    //           // childAspectRatio: 3 / 2,
                    //           // crossAxisSpacing: 10,
                    //           // mainAxisSpacing: 10,
                    //         )))
                  ],
                ),
              );
            },
          )),
    );
  }
}
