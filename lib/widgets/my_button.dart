import 'package:Ecommerce/constatns.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyButton extends StatelessWidget {
  final Function fun;
  final String text;
  MyButton({this.fun, this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 9.5.h,
      width: double.infinity,
      child: FlatButton(
        onPressed: () {
          fun();
        },
        child: Text(
          text,
          style: myGoogleFont(Colors.white, 15.5.sp, FontWeight.w500),
        ),
        color: darkColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
