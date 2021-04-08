import 'package:Ecommerce/constatns.dart';
import 'package:Ecommerce/providers/toggle_provider.dart';
import 'package:Ecommerce/providers/user_provider.dart';
import 'package:Ecommerce/screens/toggle_screen.dart';
import 'package:Ecommerce/widgets/list_view_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProductsOverview extends StatefulWidget {
  @override
  _ProductsOverviewState createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  bool isSearch = false;
  String title = '';
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<UserProvider>(
          builder: (context, product, _) {
            return Row(
              children: [
                Consumer<ToggleProvider>(
                  builder: (context, toggleProvider, _) {
                    return GestureDetector(
                      onTap: () {
                        if (!toggleProvider.isDrawerOpen) {
                          toggleProvider.changeToValues();
                        } else {
                          toggleProvider.changeToZero();
                        }
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(myUser.imageUrl),
                        radius: 19.0.sp,
                      ),
                    );
                  },
                ),
                SizedBox(width: 5.0.w),
                Text(
                  'Hi, ${myUser.userName}!',
                  style: myGoogleFont(darkColor, 13.5.sp, FontWeight.w600),
                ),
                Spacer(),
                GestureDetector(
                  child: Icon(
                    Icons.search_rounded,
                    color: darkColor,
                    size: 23.0.sp,
                  ),
                )
                // IconButton(
                //     icon: Icon(
                //       Icons.search_rounded,
                //       color: darkColor,
                //       size: 23.0.sp,
                //     ),
                //     onPressed: () {
                //       setState(() {
                //         isSearch = true;
                //       });
                //     }),
              ],
            );
          },
        ),
        isSearch
            ? TextField(
                onChanged: (val) {
                  setState(() {
                    title = val;
                  });
                },
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                  icon: Icon(Icons.cancel_outlined),
                  onPressed: () {
                    setState(() {
                      isSearch = false;
                    });
                  },
                )),
              )
            : Container(),
        ListViewProducts(false, isSearch, title),
      ],
    );
  }
}
