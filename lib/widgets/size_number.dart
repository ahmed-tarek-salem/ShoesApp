import 'package:Ecommerce/constatns.dart';
import 'package:Ecommerce/providers/tabbar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SizeNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = Provider.of<SizeNumberModel>(context);
    final tab = Provider.of<TabBarProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(right: 45.0),
      child: GestureDetector(
        onTap: () {
          tab.markAsFavorite(size.number);
        },
        child: CircleAvatar(
          backgroundColor: size.isFav ? darkColor : Colors.white,
          radius: 30,
          child: Text(
            size.number.toString(),
            style: myGoogleFont(
                size.isFav ? Colors.white : darkColor.withOpacity(0.3),
                22,
                FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
