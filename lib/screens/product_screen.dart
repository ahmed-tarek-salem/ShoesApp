import 'package:Ecommerce/constatns.dart';
import 'package:Ecommerce/models/product.dart';
import 'package:Ecommerce/providers/cart_provider.dart';
import 'package:Ecommerce/providers/products_provider.dart';
import 'package:Ecommerce/providers/tabbar_provider.dart';
import 'package:Ecommerce/screens/toggle_screen.dart';
import 'package:Ecommerce/widgets/my_button.dart';
import 'package:Ecommerce/widgets/size_number.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  final Product myProduct;
  ProductScreen(this.myProduct);
  removeProduct(BuildContext context) {
    Provider.of<ProductsProvider>(context, listen: false)
        .removeProduct(myProduct.id);
    Navigator.pop(context);
  }

  showDialoge(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('DELETING PRODUCT'),
            content:
                Text('As admin, are you sure you want to remove this product?'),
            actions: [
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  removeProduct(context);
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.arrow_back_ios,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    myUser.isAdmin == false
                        ? Container()
                        : GestureDetector(
                            child: Icon(
                              Icons.remove,
                            ),
                            onTap: () async {
                              await showDialoge(context);
                            },
                          ),
                  ],
                ),
              ),
              Image.network(
                myProduct.imageUrl,
                height: 250,
                fit: BoxFit.cover,
              ),
              Text(
                myProduct.title,
                textAlign: TextAlign.center,
                style: myGoogleFont(darkColor, 27, FontWeight.w700),
              ),
              Text(
                'STYLE:C5A20-100',
                style: myGoogleFont(Colors.grey[350], 17, FontWeight.w400),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  myProduct.desc,
                  style: myGoogleFont(darkColor, 19, FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                height: 100,
                width: double.infinity,
                child: Consumer<TabBarProvider>(
                  builder: (context, provider, child) {
                    provider.setTheList();
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                          value: provider.list[index],
                          child: SizeNumber(),
                        );
                      },
                    );
                  },
                ),
              ),
              MyButton(
                fun: () async {
                  int size = Provider.of<TabBarProvider>(context, listen: false)
                      .returnTheSize();
                  final provider =
                      Provider.of<CartProvider>(context, listen: false);
                  await provider.addItem(myProduct, size);
                },
                text: 'Add to cart - \$${myProduct.price}',
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      )),
    );
  }
}
