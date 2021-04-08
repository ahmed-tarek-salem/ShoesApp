import 'dart:ui';

import 'package:Ecommerce/constatns.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PrivacyScreen extends StatelessWidget {
  static const routeName = '/privacy-screen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/shoes.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 62.5.h,
                width: 73.0.w,
                color: darkColor.withOpacity(.3),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 3.5.w, vertical: 3.0.h),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 1.5.h,
                          ),
                          child: Text(
                            'PRIVACY POLICY STATEMENT',
                            textAlign: TextAlign.center,
                            style: myUpuntoFont(
                                Colors.white, 14.0.sp, FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 9.5.w),
                          child: Divider(color: Colors.white),
                        ),
                        Text(
                          'We know that you care how information about you is used and shared, and we appreciate your trust that we will do so carefully and sensibly. This Privacy Notice describes how ShopApp.com and its affiliates (collectively "ShopApp") collect and process your personal information through ShopApp websites, devices, products, services, online and physical stores, and applications that reference this Privacy Notice (together "ShopApp Services"). ',
                          style: myUpuntoFont(
                              Colors.white, 12.0.sp, FontWeight.w300),
                        ),
                        SizedBox(height: 3.0.h),
                        Text(
                          'What Personal Information About Customers Does ShopApp Collect?',
                          style: myUpuntoFont(
                            Colors.white,
                            13.0.sp,
                            FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 3.0.h),
                        Text(
                          'Information You Give Us: We receive and store any information you provide in relation to ShopApp Services. Click here to see examples of what we collect. You can choose not to provide certain information, but then you might not be able to take advantage of many of our ShopApp Services.',
                          style: myUpuntoFont(
                            Colors.white,
                            11.5.sp,
                            FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              child: backArrow(context),
              top: 1.5.h,
              left: 12.0.w,
            ),
          ],
        ),
      ),
    );
  }
}
