import 'package:Ecommerce/models/user.dart';
import 'package:Ecommerce/providers/user_provider.dart';
import 'package:Ecommerce/screens/drawer_screen.dart';
import 'package:Ecommerce/screens/home_screen.dart';
import 'package:Ecommerce/services/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String userId;
User myUser;

class ToggleScreen extends StatefulWidget {
  static const routeName = '/toggle-screen';

  @override
  _ToggleScreenState createState() => _ToggleScreenState();
}

class _ToggleScreenState extends State<ToggleScreen> {
  bool isLoading = true;
  bool isInit = true;
  CollectionReference userRef = FirebaseFirestore.instance.collection('users');

  retrieveUserData(bool rememberMe) async {
    userId = await SharedPref().checkIfLoggedIn();
    myUser =
        await Provider.of<UserProvider>(context, listen: false).defineUser();
    if (rememberMe == false) {
      await SharedPref().removeMark();
    }
  }

  @override
  void didChangeDependencies() async {
    if (isInit) {
      final rememberMe = ModalRoute.of(context).settings.arguments as bool;
      await retrieveUserData(rememberMe);
      setState(() {
        isLoading = false;
      });

      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: double.infinity,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  DrawerScreen(),
                  HomeScreen(),
                ],
              ),
            ),
    );
  }
}
