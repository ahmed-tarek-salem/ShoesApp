import 'package:Ecommerce/constatns.dart';
import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: AssetImage('images/nodata.png'),
        ),
        Column(
          children: [
            Text(
              'Your pretty list is empty!',
              textAlign: TextAlign.center,
              style: myUpuntoFont(darkColor, 35, FontWeight.w600),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
              child: Text(
                'Choose some favorite products, and try agian',
                textAlign: TextAlign.center,
                style: myUpuntoFont(darkColor, 20, FontWeight.w300),
              ),
            )
          ],
        ),
      ],
    );
  }
}
