import 'package:Ecommerce/constatns.dart';
import 'package:Ecommerce/models/product.dart';
import 'package:Ecommerce/screens/product_screen.dart';
import 'package:Ecommerce/screens/toggle_screen.dart';
import 'package:Ecommerce/services/database_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myProduct = Provider.of<Product>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductScreen(myProduct);
        }));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        //  height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(0xffECEFF1),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
          child: Column(
            children: [
              Align(
                child: GestureDetector(
                  onTap: () {
                    myProduct.toggleFavorite();
                    DatabaseMethods().handleToggleLike(
                        userId, myProduct.id, myProduct.isFavorite);
                  },
                  child: Icon(
                    myProduct.isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border,
                    size: 30,
                  ),
                ),
                alignment: Alignment.topRight,
              ),
              Transform.translate(
                offset: Offset(0, -30),
                child: Image.network(
                  myProduct.imageUrl,
                  height: 115,
                  width: 230,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  Text(
                    myProduct.title,
                    textAlign: TextAlign.center,
                    style: myGoogleFont(darkColor, 18, FontWeight.w700),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '\$${myProduct.price}',
                    style: myGoogleFont(darkColor, 15, FontWeight.w300),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
