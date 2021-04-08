import 'package:Ecommerce/constatns.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RadioButton extends StatelessWidget {
  final bool radioValue;
  RadioButton(this.radioValue);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      child: Stack(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: darkColor,
          ),
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 13,
              backgroundColor: Colors.white,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 11,
              backgroundColor: radioValue ? darkColor : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
