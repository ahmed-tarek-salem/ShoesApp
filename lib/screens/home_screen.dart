import 'dart:async';

import 'package:Ecommerce/constatns.dart';
import 'package:Ecommerce/providers/cart_provider.dart';
import 'package:Ecommerce/providers/products_provider.dart';
import 'package:Ecommerce/providers/toggle_provider.dart';
import 'package:Ecommerce/screens/cart_screen.dart';
import 'package:Ecommerce/screens/favorite_screen.dart';
import 'package:Ecommerce/screens/products_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  bool isInit = true;
  int currentPage = 0;
  Timer timer;
  int start = 1;
  void startTimer() {
    const oneSec = const Duration(milliseconds: 1000);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          setState(() {
            timer.cancel();
            currentPage = 0;
          });
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  @override
  void didChangeDependencies() async {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      await Provider.of<ProductsProvider>(context, listen: false).fetchItems();
      await Provider.of<CartProvider>(context, listen: false).fetchCarts();
      startTimer();
      setState(() {
        isLoading = false;
        currentPage = 0;
      });
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<ToggleProvider>(context);
    return GestureDetector(
      onTap: () {
        if (dataProvider.isDrawerOpen) {
          dataProvider.changeToZero();
        }
      },
      child: AnimatedContainer(
        transform: Matrix4.translationValues(
            dataProvider.xOffset, dataProvider.yOffset, 0)
          ..scale(dataProvider.scaleFactor),
        duration: Duration(milliseconds: 250),
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
            child: Column(
              children: [
                Expanded(
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : PageView.builder(
                          onPageChanged: (val) {
                            setState(() {
                              currentPage = val;
                            });
                          },
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            if (currentPage == 0)
                              return ProductsOverview();
                            else if (currentPage == 1)
                              return FavoriteScreen();
                            else
                              return CartScreen();
                          },
                        ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Stack(
                    children: [
                      Container(
                        height: 50,
                        width: double.infinity,
                        color: Colors.grey[100],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 0,
                              offset: Offset(0.5, .5), //(x,y)
                              blurRadius: 20.0,
                            ),
                          ],
                        ),
                        width: double.infinity,
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.home_filled,
                                  size: 35,
                                  color: currentPage == 0
                                      ? darkColor
                                      : Colors.grey[300],
                                ),
                                onPressed: () {
                                  setState(() {
                                    currentPage = 0;
                                  });
                                }),
                            IconButton(
                                icon: Icon(
                                  Icons.favorite_outline,
                                  size: 35,
                                  color: currentPage == 1
                                      ? darkColor
                                      : Colors.grey[300],
                                ),
                                onPressed: () {
                                  setState(() {
                                    currentPage = 1;
                                  });
                                }),
                            IconButton(
                                icon: Icon(
                                  Icons.shopping_cart_sharp,
                                  size: 35,
                                  color: currentPage == 2
                                      ? darkColor
                                      : Colors.grey[300],
                                ),
                                onPressed: () {
                                  setState(() {
                                    currentPage = 2;
                                  });
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
