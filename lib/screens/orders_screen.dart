import 'package:Ecommerce/constatns.dart';
import 'package:Ecommerce/models/order.dart';
import 'package:Ecommerce/providers/order_provider.dart';
import 'package:Ecommerce/screens/empty_orders.dart';
import 'package:Ecommerce/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders-screen';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool isInit = true;
  @override
  void didChangeDependencies() async {
    if (isInit) {
      await Provider.of<OrderProvider>(context).fetchOrders();

      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: Provider.of<OrderProvider>(context).orders.length == 0
            ? EmptyOrders()
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: false,
                      expandedHeight: 120,
                      leading: backArrow(context),
                      backgroundColor: Colors.grey[50],
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text(
                          'Orders',
                          style: myGoogleFont(darkColor, 30, FontWeight.w500),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 30,
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BorderdContainer(
                          containerColor: yellowColor,
                          isBorder: false,
                          text: 'Processing',
                          textColor: Colors.white,
                        ),
                        BorderdContainer(
                          containerColor: Colors.white,
                          isBorder: true,
                          text: 'Delivered ',
                          textColor: yellowColor,
                        ),
                        BorderdContainer(
                          containerColor: Colors.white,
                          isBorder: true,
                          text: 'Cancelled',
                          textColor: yellowColor,
                        ),
                      ],
                    )),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        List<Order> orders =
                            Provider.of<OrderProvider>(context).orders;
                        return OrderItem(orders[index]);
                      },
                          childCount: Provider.of<OrderProvider>(context)
                              .orders
                              .length),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

class BorderdContainer extends StatelessWidget {
  final Color textColor;
  final String text;
  final bool isBorder;
  final Color containerColor;
  BorderdContainer(
      {this.containerColor, this.isBorder, this.textColor, this.text});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: 3),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
            border: isBorder
                ? Border.all(color: yellowColor, width: 1)
                : Border.all(width: 0, color: yellowColor),
            color: containerColor,
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          text,
          style: myGoogleFont(textColor, 17, FontWeight.w300),
        ),
      ),
    );
  }
}
