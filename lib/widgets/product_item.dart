import 'package:Ecommerce/constatns.dart';
import 'package:Ecommerce/models/product.dart';
import 'package:Ecommerce/screens/product_screen.dart';
import 'package:Ecommerce/screens/toggle_screen.dart';
import 'package:Ecommerce/services/database_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myProduct = Provider.of<Product>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductScreen(myProduct);
        }));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 1.0.h),
        //  height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(0xffECEFF1),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 3.0.h, horizontal: 4.0.w),
          child: Column(
            children: [
              Align(
                child: GestureDetector(
                  onTap: () {
                    myProduct.toggleFavorite();
                    DatabaseMethods().handleToggleLike(
                        userId, myProduct.id, myProduct.isFavorite);
                  },
                  child: Icon(
                    myProduct.isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border,
                    size: 23.0.sp,
                  ),
                ),
                alignment: Alignment.topRight,
              ),
              Transform.translate(
                offset: Offset(0, -30),
                child: Image.network(
                  myProduct.imageUrl,
                  height: 19.0.h,
                  width: 56.0.w,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  Text(
                    myProduct.title,
                    textAlign: TextAlign.center,
                    style: myGoogleFont(darkColor, 14.0.sp, FontWeight.w700),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    '\$${myProduct.price}',
                    style: myGoogleFont(darkColor, 11.5.sp, FontWeight.w300),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
