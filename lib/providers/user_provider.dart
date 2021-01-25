import 'package:Ecommerce/models/user.dart';
import 'package:Ecommerce/screens/toggle_screen.dart';
import 'package:Ecommerce/services/database_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  User myUser;

  defineUser() async {
    CollectionReference refUsers =
        FirebaseFirestore.instance.collection('users');
    DocumentSnapshot doc = await refUsers.doc(userId).get();
    User thisUser = User.fromDocument(doc);
    myUser = thisUser;
    notifyListeners();
    return thisUser;
  }

  updatePhoto(url) {
    myUser.imageUrl = url;
    notifyListeners();
  }

  updateUserInfo(
      String name, String address, int phone, int years, int card) async {
    myUser.address = address;
    myUser.card = card;
    myUser.phone = phone;
    myUser.years = years;
    myUser.userName = name;
    notifyListeners();
    await DatabaseMethods().updateUserInfo(name, address, phone, years, card);
  }

  String returnCardNumber() {
    String updatedNum = '';
    for (int i = 0, j = 0; i < myUser.card.toString().length; i++, j++) {
      if (j < 3) {
        updatedNum += myUser.card.toString()[i];
      } else {
        j = 0;
        updatedNum += ' ';
        updatedNum += myUser.card.toString()[i];
      }
    }
    return updatedNum;
  }
}
