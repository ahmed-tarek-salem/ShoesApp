import 'package:Ecommerce/constatns.dart';
import 'package:Ecommerce/models/cart.dart';
import 'package:Ecommerce/providers/cart_provider.dart';
import 'package:Ecommerce/providers/order_provider.dart';
import 'package:Ecommerce/screens/empty_cart.dart';
import 'package:Ecommerce/widgets/cart_item.dart';
import 'package:Ecommerce/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart-screen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<CartProvider>(context);
    Map<String, Cart> map = dataProvider.getItems();
    return SafeArea(
      child: Scaffold(
        body: map.length == 0
            ? EmptyCart()
            : isLoading
                ? Center(child: CircularProgressIndicator())
                : CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        expandedHeight: 20.0.h,
                        backgroundColor: Colors.white,
                        leading: IconButton(
                          icon: Icon(
                            Icons.remove_shopping_cart_rounded,
                            size: 23.0.sp,
                          ),
                          onPressed: () async {
                            return await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Deleting process'),
                                    content: Text(
                                        'You are about to remove all items in your cart'),
                                    actions: [
                                      FlatButton(
                                        child: Text('cancel'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      FlatButton(
                                        child: Text('continue'),
                                        onPressed: () async {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          await dataProvider.removeAllItems();
                                          setState(() {
                                            isLoading = false;
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                          color: darkColor,
                        ),
                        flexibleSpace: FlexibleSpaceBar(
                          title: Text(
                            'My cart',
                            style: myGoogleFont(
                                darkColor, 23.0.sp, FontWeight.w500),
                          ),
                        ),
                        // actions: [
                        //   IconButton(
                        //     icon: Icon(
                        //       Icons.search_rounded,
                        //       size: 27.0.sp,
                        //       color: darkColor,
                        //     ),
                        //     onPressed: () {},
                        //   ),
                        // ],
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          Cart cart = Cart(
                              myProduct: map.values.toList()[index].myProduct,
                              quantity: map.values.toList()[index].quantity,
                              size: map.values.toList()[index].size);
                          return CartItem(cart);
                        }, childCount: map.length),
                      ),
                      SliverToBoxAdapter(
                          child: Column(
                        children: [
                          SizedBox(height: 2.0.h),
                          Divider(color: Colors.grey[400]),
                          CartRow(
                            leftText:
                                'Subtotal (${dataProvider.getCount()} items)',
                            rightText: '\$ ${dataProvider.getPrice()}',
                          ),
                          CartRow(
                            leftText: 'Delivery Charge',
                            rightText: '\$ 10',
                          ),
                          CartRow(
                            leftText: 'Total',
                            rightText: '\$ ${dataProvider.getPrice() + 10}',
                            isDark: true,
                          ),
                          SizedBox(
                            height: 2.0.h,
                          ),
                          MyButton(
                            text: 'Checkout',
                            fun: () async {
                              await Provider.of<OrderProvider>(context,
                                      listen: false)
                                  .addOrder(map.values.toList(),
                                      dataProvider.getPrice());
                              await Provider.of<CartProvider>(context,
                                      listen: false)
                                  .removeAllItems();
                            },
                          )
                        ],
                      ))
                    ],
                  ),
      ),
    );
  }
}

class CartRow extends StatelessWidget {
  CartRow({this.leftText, this.rightText, this.isDark});
  final String leftText;
  final String rightText;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(leftText,
              style: myGoogleFont(
                Colors.grey[400],
                isDark == null ? 13.0.sp : 17.0.sp,
                FontWeight.w400,
              )),
          Text(rightText,
              style: myGoogleFont(
                  isDark == null ? Colors.grey[400] : darkColor,
                  isDark == null ? 13.0.sp : 17.0.sp,
                  isDark == null ? FontWeight.w400 : FontWeight.w600)),
        ],
      ),
    );
  }
}
