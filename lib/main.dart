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
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //runApp(MyApp());
  runApp(DevicePreview(builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizerUtil().init(constraints, orientation);
              return MaterialApp(
                theme: new ThemeData(
                    scaffoldBackgroundColor: const Color(0xFFFFFFFF)),
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
              );
            },
          );
        },
      ),
    );
  }
}
