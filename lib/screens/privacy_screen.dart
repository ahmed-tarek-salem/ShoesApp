import 'dart:ui';

import 'package:Ecommerce/constatns.dart';
import 'package:flutter/material.dart';

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
                height: 400,
                width: 300,
                color: darkColor.withOpacity(.3),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10.0,
                          ),
                          child: Text(
                            'PRIVACY POLICY STATEMENT',
                            textAlign: TextAlign.center,
                            style:
                                myUpuntoFont(Colors.white, 18, FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Divider(color: Colors.white),
                        ),
                        Text(
                          'We know that you care how information about you is used and shared, and we appreciate your trust that we will do so carefully and sensibly. This Privacy Notice describes how ShopApp.com and its affiliates (collectively "ShopApp") collect and process your personal information through ShopApp websites, devices, products, services, online and physical stores, and applications that reference this Privacy Notice (together "ShopApp Services"). ',
                          style:
                              myUpuntoFont(Colors.white, 16, FontWeight.w300),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'What Personal Information About Customers Does ShopApp Collect?',
                          style: myUpuntoFont(
                            Colors.white,
                            17,
                            FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Information You Give Us: We receive and store any information you provide in relation to ShopApp Services. Click here to see examples of what we collect. You can choose not to provide certain information, but then you might not be able to take advantage of many of our ShopApp Services.',
                          style: myUpuntoFont(
                            Colors.white,
                            15,
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
              top: 10,
              left: 50,
            ),
          ],
        ),
      ),
    );
  }
}
