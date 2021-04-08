import 'package:Ecommerce/constatns.dart';
import 'package:Ecommerce/providers/toggle_provider.dart';
import 'package:Ecommerce/screens/add_product.dart';
import 'package:Ecommerce/screens/orders_screen.dart';
import 'package:Ecommerce/screens/privacy_screen.dart';
import 'package:Ecommerce/screens/profile_screen.dart';
import 'package:Ecommerce/screens/sign_up.dart';
import 'package:Ecommerce/screens/toggle_screen.dart';
import 'package:Ecommerce/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class DrawerScreen extends StatelessWidget {
  logOut(BuildContext context) async {
    await AuthMethods().logOut();
    Navigator.pushReplacementNamed(context, SignUp.routeName);
    Provider.of<ToggleProvider>(context, listen: false).changeToZero();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 4.5.h, horizontal: 7.3.w),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              //   color: Color(0xff03000a),
              color: darkColor),
          child: ListView(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(myUser.imageUrl),
                    radius: 19.0.sp,
                  ),
                  SizedBox(width: 2.0.w),
                  Text(
                    myUser.userName,
                    style: myGoogleFont(Colors.white, 14.0.sp, FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: 4.5.h,
              ),
              DrawerTab('Profile', Icons.person_pin,
                  route: ProfileScreen.routeName),
              DrawerTab(
                'Home',
                Icons.home_filled,
              ),
              DrawerTab(
                'Orders',
                Icons.shopping_cart_rounded,
                route: OrdersScreen.routeName,
              ),
              DrawerTab('Privacy policy', Icons.book_rounded,
                  route: PrivacyScreen.routeName),
              // myUser.isAdmin == true
              //     ?
              Visibility(
                visible: myUser.isAdmin,
                child: DrawerTab(
                  'Add product',
                  Icons.person_pin,
                  noDivider: true,
                  route: AddProduct.routeName,
                ),
              ),
              // : Container(),
              // IconButton(
              //     icon: Icon(Icons.search_off),
              //     onPressed: () {
              //       AuthMethods().logOut();
              //       Navigator.of(context)
              //           .pushReplacementNamed(SignUp.routeName);
              //     }),
              // IconButton(
              //     icon: Icon(Icons.card_travel),
              //     onPressed: () {
              //       Provider.of<ToggleProvider>(context, listen: false)
              //           .removeHome();
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) {
              //         return ProfileScreen();
              //       }));
              //     }),
              SizedBox(height: 19.0.h),
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await logOut(context);
                      // Provider.of<ToggleProvider>(context, listen: false)
                      //     .changeToZero();
                    },
                    child: Text(
                      'Sign-out ',
                      style:
                          myGoogleFont(yellowColor, 14.0.sp, FontWeight.w500),
                    ),
                  ),
                  Icon(Icons.arrow_forward, size: 23.0.sp, color: Colors.white)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerTab extends StatelessWidget {
  final String text;
  final icon;
  bool noDivider = false;
  final route;
  DrawerTab(this.text, this.icon, {this.noDivider, this.route});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (route != null) {
          Navigator.of(context).pushNamed(route);
          Provider.of<ToggleProvider>(context, listen: false).removeHome();
        } else {
          Provider.of<ToggleProvider>(context, listen: false).changeToZero();
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 21.5.sp,
                color: yellowColor,
              ),
              SizedBox(width: 2.0.w),
              Text(
                text,
                style: myGoogleFont(Colors.white, 13.0.sp, FontWeight.w500),
              )
            ],
          ),
          noDivider == true
              ? Container()
              : Container(
                  margin: EdgeInsets.only(
                    left: 10.0.w,
                    top: 2.8.h,
                    bottom: 2.8.h,
                  ),
                  height: 1,
                  width: 29.0.w,
                  color: yellowColor
                  // Colors.grey[800],
                  )
        ],
      ),
    );
  }
}
/*
{
  "title": "Adidas Sok Pro 1110",
  "image" : "https://freepngimg.com/thumb/shoes/27428-5-nike-shoes-transparent-background.png",
  "desc" : "Very good new shoes for you",
  "price": "120"
}


*/
