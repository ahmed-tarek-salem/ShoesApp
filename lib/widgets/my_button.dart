import 'package:Ecommerce/constatns.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function fun;
  final String text;
  MyButton({this.fun, this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: FlatButton(
        onPressed: () {
          fun();
        },
        child: Text(
          text,
          style: myGoogleFont(Colors.white, 20, FontWeight.w500),
        ),
        color: darkColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
