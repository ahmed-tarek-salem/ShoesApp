import 'package:Ecommerce/providers/cart_provider.dart';
import 'package:Ecommerce/providers/order_provider.dart';
import 'package:Ecommerce/providers/products_provider.dart';
import 'package:Ecommerce/providers/tabbar_provider.dart';
import 'package:Ecommerce/providers/toggle_provider.dart';
import 'package:Ecommerce/providers/user_provider.dart';
import 'package:Ecommerce/screens/add_product.dart';
import 'package:Ecommerce/screens/edit_profile.dart';
import 'package:Ecommerce/screens/orders_screen.dart';
import 'package:Ecommerce/screens/privacy_screen.dart';
import 'package:Ecommerce/screens/profile_screen.dart';
import 'package:Ecommerce/screens/toggle_screen.dart';
import 'package:Ecommerce/screens/sign_up.dart';
import 'package:Ecommerce/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return ToggleProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return ProductsProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return TabBarProvider();
          },
        ),
        ChangeNotifierProvider(create: (context) {
          return CartProvider();
        }),
        ChangeNotifierProvider(create: (context) {
          return OrderProvider();
        }),
        ChangeNotifierProvider(create: (context) {
          return UserProvider();
        }),
      ],
      child: MaterialApp(
        theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFFFFFFFF)),
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen(),
        routes: {
          SignUp.routeName: (context) {
            return SignUp();
          },
          ToggleScreen.routeName: (context) {
            return ToggleScreen();
          },
          ProfileScreen.routeName: (context) {
            return ProfileScreen();
          },
          OrdersScreen.routeName: (context) {
            return OrdersScreen();
          },
          EditProfile.routeName: (context) {
            return EditProfile();
          },
          AddProduct.routeName: (context) {
            return AddProduct();
          },
          PrivacyScreen.routeName: (context) {
            return PrivacyScreen();
          },
        },
      ),
    );
  }
}
