import 'package:Ecommerce/constatns.dart';
import 'package:Ecommerce/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

List<Map<String, String>> splashData = [
  {
    'title': 'BE ALWAYS UNIQE',
    'image': 'images/vector-creator.png',
    'text':
        'We offer you the latest trends and products from all over the world'
  },
  {
    'title': 'DO ONLINE SHOPPING',
    'image': 'images/shopping.png',
    'text': 'Choose from best collections and add them to your cart'
  },
  {
    'title': 'SEND YOUR ORDER',
    'image': 'images/confirmed.png',
    'text':
        'We are always ready for receiving your orders, it will be your home in no time'
  },
];

class SplashContent extends StatelessWidget {
  final String title;
  final String text;
  final String image;
  final int currentPage;
  SplashContent(this.title, this.image, this.text, this.currentPage);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          image: AssetImage(image),
          height: 350,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: myGoogleFont(darkColor, 30, FontWeight.w500),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: myGoogleFont(darkColor, 20, FontWeight.w300),
          ),
        ),
        Spacer(),
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children:
                List.generate(3, (index) => BuildDot(index, currentPage))),
      ],
    );
  }
}
