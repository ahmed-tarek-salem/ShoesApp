import 'package:Ecommerce/constatns.dart';
import 'package:Ecommerce/providers/tabbar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SizeNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = Provider.of<SizeNumberModel>(context);
    final tab = Provider.of<TabBarProvider>(context);
    return Padding(
      padding: EdgeInsets.only(right: 12.0.w),
      child: GestureDetector(
        onTap: () {
          tab.markAsFavorite(size.number);
        },
        child: CircleAvatar(
          backgroundColor: size.isFav ? darkColor : Colors.white,
          radius: 23.0.sp,
          child: Text(
            size.number.toString(),
            style: myGoogleFont(
                size.isFav ? Colors.white : darkColor.withOpacity(0.3),
                17.0.sp,
                FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
