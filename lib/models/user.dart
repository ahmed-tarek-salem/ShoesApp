import 'package:flutter/cupertino.dart';

class User with ChangeNotifier {
  String userName;
  String imageUrl;
  String userId;
  int phone;
  String address;
  int years;
  int card;
  bool isAdmin;

  User(
      {this.userName,
      this.imageUrl,
      this.userId,
      this.phone,
      this.address,
      this.card,
      this.years,
      @required this.isAdmin});

  factory User.fromDocument(doc) {
    return User(
      phone: doc['phone'],
      userName: doc['userName'],
      imageUrl: doc['imageUrl'],
      address: doc['address'],
      card: doc['card'],
      userId: doc['userId'],
      years: doc['years'],
      isAdmin: doc['isAdmin'],
    );
  }
}
