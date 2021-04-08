import 'package:Ecommerce/constatns.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image(
          image: AssetImage('images/nodata.png'),
          height:
              SizerUtil.orientation == Orientation.portrait ? 40.0.h : 20.0.h,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Your pretty list is empty!',
                textAlign: TextAlign.center,
                style: myUpuntoFont(darkColor, 27.0.sp, FontWeight.w600),
              ),
              Text(
                'Choose some favorite products, and try agian',
                textAlign: TextAlign.center,
                style: myUpuntoFont(darkColor, 15.0.sp, FontWeight.w300),
              )
            ],
          ),
        ),
      ],
    );
  }
}
