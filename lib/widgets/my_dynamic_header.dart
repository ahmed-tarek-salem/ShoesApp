import 'package:Ecommerce/constatns.dart';
import 'package:Ecommerce/providers/cart_provider.dart';
import 'package:Ecommerce/providers/order_provider.dart';
import 'package:Ecommerce/providers/products_provider.dart';
import 'package:Ecommerce/providers/user_provider.dart';
import 'package:Ecommerce/screens/edit_profile.dart';
import 'package:Ecommerce/widgets/change_photo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

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
            height: 70.0.h,
            width: double.infinity,
            child: SafeArea(child: Consumer<UserProvider>(
              builder: (context, provider, _) {
                return Center(
                  child: Image.network(
                    provider.myUser.imageUrl,
                    fit: BoxFit.cover,
                    height: 70.0.h,
                    width: double.infinity,
                  ),
                );
              },
            )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.0.w),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  backArrow(context, color: Colors.white),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.white),
                    iconSize: 19.0.sp,
                    onPressed: () {
                      Navigator.of(context).pushNamed(EditProfile.routeName);
                    },
                  ),
                ]),
          ),
          Positioned(
              bottom: 7.8.h,
              left: 4.8.w,
              child: Consumer<UserProvider>(
                builder: (context, provider, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.myUser.userName,
                        style:
                            myGoogleFont(yellowColor, 25.0.sp, FontWeight.w500),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 1.0.h, bottom: 0.2.h),
                        child: Text(
                          provider.myUser.address != null
                              ? provider.myUser.address
                              : '',
                          style: myGoogleFont(
                              Colors.grey[300], 11.5.sp, FontWeight.w400),
                        ),
                      ),
                      Text(
                        provider.myUser.years != null
                            ? '${provider.myUser.years} years'
                            : '',
                        style: myGoogleFont(
                            Colors.grey[300], 11.5.sp, FontWeight.w400),
                      )
                    ],
                  );
                },
              )),
          Positioned(
            bottom: -5.5.h,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0.sp),
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
              margin: EdgeInsets.symmetric(horizontal: 5.0.w),
              height: 11.0.h,
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
                                Colors.grey[700], 15.0.sp, FontWeight.w500),
                          );
                        },
                      ),
                      Text(
                        'Favorites',
                        style: myGoogleFont(
                            Colors.grey[400], 11.5.sp, FontWeight.w400),
                      ),
                    ],
                  ),
                  ProfileSmallDivider(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<CartProvider>(
                        builder: (context, provider, _) {
                          return Text(
                            provider.items.length.toString(),
                            style: myGoogleFont(
                                Colors.grey[700], 15.0.sp, FontWeight.w500),
                          );
                        },
                      ),
                      Text(
                        'Cart',
                        style: myGoogleFont(
                            Colors.grey[400], 11.5.sp, FontWeight.w400),
                      ),
                    ],
                  ),
                  ProfileSmallDivider(),
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
                                  Colors.grey[700], 15.0.sp, FontWeight.w500),
                            );
                          },
                        ),
                        Text(
                          'Orders',
                          style: myGoogleFont(
                              Colors.grey[400], 11.5.sp, FontWeight.w400),
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
  double get maxExtent => 65.0.h;

  @override
  double get minExtent => 12.5.h;
}

class ProfileSmallDivider extends StatelessWidget {
  const ProfileSmallDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4.0.h,
      width: 0.5.w,
      color: Colors.grey[300],
    );
  }
}
