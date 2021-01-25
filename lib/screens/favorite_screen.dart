import 'package:Ecommerce/widgets/list_view_products.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = '/favorite-screen';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [ListViewProducts(true, false, '')],
    );
  }
}
