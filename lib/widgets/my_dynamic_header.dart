import 'package:Ecommerce/constatns.dart';
import 'package:Ecommerce/providers/cart_provider.dart';
import 'package:Ecommerce/providers/order_provider.dart';
import 'package:Ecommerce/providers/products_provider.dart';
import 'package:Ecommerce/providers/user_provider.dart';
import 'package:Ecommerce/screens/edit_profile.dart';
import 'package:Ecommerce/widgets/change_photo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDynamicHeader extends SliverPersistentHeaderDelegate {
  int index = 0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            height: 415,
            width: double.infinity,
            child: SafeArea(child: Consumer<UserProvider>(
              builder: (context, provider, _) {
                return Center(
                  child: Image.network(
                    provider.myUser.imageUrl,
                    fit: BoxFit.cover,
                    height: 415,
                    width: double.infinity,
                  ),
                );
              },
            )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  backArrow(context, color: Colors.white),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.white),
                    iconSize: 25,
                    onPressed: () {
                      Navigator.of(context).pushNamed(EditProfile.routeName);
                    },
                  ),
                ]),
          ),
          Positioned(
              bottom: 50,
              left: 20,
              child: Consumer<UserProvider>(
                builder: (context, provider, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.myUser.userName,
                        style: myGoogleFont(Colors.white, 33, FontWeight.w500),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 1),
                        child: Text(
                          provider.myUser.address != null
                              ? provider.myUser.address
                              : '',
                          style: myGoogleFont(
                              Colors.grey[300], 15, FontWeight.w300),
                        ),
                      ),
                      Text(
                        provider.myUser.years != null
                            ? '${provider.myUser.years} years'
                            : '',
                        style:
                            myGoogleFont(Colors.grey[300], 15, FontWeight.w300),
                      )
                    ],
                  );
                },
              )),
          Positioned(
            bottom: -35,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 0,
                    offset: Offset(0.5, .5), //(x,y)
                    blurRadius: 20.0,
                  ),
                ],
              ),
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 70,
              // width: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<ProductsProvider>(
                        builder: (context, provider, _) {
                          return Text(
                            provider.getItems(true).length.toString(),
                            style: myGoogleFont(
                                Colors.grey[700], 20, FontWeight.w500),
                          );
                        },
                      ),
                      Text(
                        'Favorites',
                        style:
                            myGoogleFont(Colors.grey[400], 15, FontWeight.w400),
                      ),
                    ],
                  ),
                  Container(
                    height: 25,
                    width: 2,
                    color: Colors.grey[300],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<CartProvider>(
                        builder: (context, provider, _) {
                          return Text(
                            provider.items.length.toString(),
                            style: myGoogleFont(
                                Colors.grey[700], 20, FontWeight.w500),
                          );
                        },
                      ),
                      Text(
                        'Cart',
                        style:
                            myGoogleFont(Colors.grey[400], 15, FontWeight.w400),
                      ),
                    ],
                  ),
                  Container(
                    height: 25,
                    width: 2,
                    color: Colors.grey[300],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Consumer<OrderProvider>(
                          builder: (context, provider, _) {
                            return Text(
                              provider.orders.length.toString(),
                              style: myGoogleFont(
                                  Colors.grey[700], 20, FontWeight.w500),
                            );
                          },
                        ),
                        Text(
                          'Orders',
                          style: myGoogleFont(
                              Colors.grey[400], 15, FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ChangePhoto()
        ],
      );
    });
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;

  @override
  double get maxExtent => 415.0;

  @override
  double get minExtent => 80.0;
}
