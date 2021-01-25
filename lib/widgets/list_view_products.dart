import 'package:Ecommerce/constatns.dart';
import 'package:Ecommerce/models/product.dart';
import 'package:Ecommerce/providers/products_provider.dart';
import 'package:Ecommerce/widgets/empty_list.dart';
import 'package:Ecommerce/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListViewProducts extends StatelessWidget {
  final bool showFavorite;
  final bool isSearch;
  final String title;
  ListViewProducts(this.showFavorite, this.isSearch, this.title);
  @override
  Widget build(BuildContext context) {
    return Expanded(child: Consumer<ProductsProvider>(
      builder: (context, provider, _) {
        List<Product> productsList = provider.getItems(showFavorite);
        if (isSearch) {
          productsList = provider.searchForProduct(title);
        }
        return productsList.length == 0 && isSearch == false
            ? EmptyList()
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: productsList.length,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            showFavorite
                                ? 'Explore your favorite list'
                                : 'Find your perfect shoes',
                            textAlign: TextAlign.center,
                            style: myGoogleFont(darkColor, 35, FontWeight.w600),
                          ),
                        ),
                        ChangeNotifierProvider.value(
                          value: productsList[index],
                          child: ProductItem(),
                        )
                      ],
                    );
                  }
                  return ChangeNotifierProvider.value(
                    value: productsList[index],
                    child: ProductItem(),
                  );
                },
              );
      },
    ));
  }
}
