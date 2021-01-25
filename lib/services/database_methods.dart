import 'package:Ecommerce/models/cart.dart';
import 'package:Ecommerce/models/order.dart';
import 'package:Ecommerce/models/product.dart';
import 'package:Ecommerce/models/user.dart';
import 'package:Ecommerce/screens/toggle_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseMethods {
  final CollectionReference refUsers =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference refProducts =
      FirebaseFirestore.instance.collection('products');
  final CollectionReference refFavorites =
      FirebaseFirestore.instance.collection('favorites');
  final CollectionReference refCarts =
      FirebaseFirestore.instance.collection('carts');
  final CollectionReference refOrders =
      FirebaseFirestore.instance.collection('orders');

  setUserInfo(
    User myUser,
  ) async {
    Map<String, dynamic> info = {
      "userName": myUser.userName,
      "imageUrl": myUser.imageUrl,
      "phone": myUser.phone,
      'address': myUser.address,
      'years': myUser.years,
      'card': myUser.card,
      'userId': myUser.userId,
      'isAdmin': false,
    };
    await refUsers.doc(myUser.userId).set(info);
  }

  updateUserInfo(
      String name, String address, int phone, int years, int card) async {
    await refUsers.doc(userId).update({
      'userName': name,
      'card': card,
      'phone': phone,
      "years": years,
      'address': address
    });
  }

  handleToggleLike(String userId, String productId, bool state) async {
    if (state) {
      await refFavorites
          .doc(userId)
          .collection('products')
          .doc(productId)
          .set({"state": true});
    } else {
      await refFavorites
          .doc(userId)
          .collection('products')
          .doc(productId)
          .delete();
    }
  }

  checkState(String userId, String productId) async {
    DocumentSnapshot doc = await refFavorites
        .doc(userId)
        .collection('products')
        .doc(productId)
        .get();
    if (doc.exists)
      return true;
    else
      return false;
  }

  addCartItem(Product myProduct, bool alreadyExists,
      {int updatedQuantyi}) async {
    if (!alreadyExists) {
      await refCarts.doc(userId).collection('items').doc(myProduct.id).set({
        'id': myProduct.id,
        'imageUrl': myProduct.imageUrl,
        'price': myProduct.price,
        'title': myProduct.title,
        'quantity': 1
      });
    } else {
      await refCarts
          .doc(userId)
          .collection('items')
          .doc(myProduct.id)
          .update({'quantity': 2});
    }
  }

  fetchCartData() async {
    Map<String, Cart> cartMap = {};
    QuerySnapshot snapshot =
        await refCarts.doc(userId).collection('items').get();
    List<dynamic> carts = snapshot.docs;
    for (int i = 0; i < carts.length; i++) {
      Product myProduct = Product(
        id: carts[i]['id'],
        title: carts[i]['title'],
        price: carts[i]['price'].toDouble(),
        imageUrl: carts[i]['imageUrl'],
      );
      Cart myCart = Cart(
          myProduct: myProduct,
          quantity: carts[i]['quantity'],
          size: carts[i]['size']);
      cartMap.putIfAbsent(myProduct.id, () => myCart);
    }
    return cartMap;
  }

  adddCartItem(Cart cart, bool alreadyExists) async {
    if (!alreadyExists) {
      await refCarts
          .doc(userId)
          .collection('items')
          .doc(cart.myProduct.id)
          .set({
        'id': cart.myProduct.id,
        'imageUrl': cart.myProduct.imageUrl,
        'price': cart.myProduct.price,
        'title': cart.myProduct.title,
        'quantity': cart.quantity,
        'size': cart.size
      });
    } else {
      await refCarts
          .doc(userId)
          .collection('items')
          .doc(cart.myProduct.id)
          .update({'quantity': cart.quantity});
    }
  }

  removeSingleCartItem(String cartId) async {
    return await refCarts.doc(userId).collection('items').doc(cartId).delete();
  }

  removeAllCartItems() async {
    refCarts.doc(userId).collection('items').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }

  addOrder(Order order) async {
    await refOrders.doc(userId).collection('ordres').doc(order.id).set({
      'dateTime': order.dateTime.toIso8601String(),
      'amount': order.amount.toString(),
      'listOfProducts': order.listOfProducts
          .map((e) => {
                'title': e.myProduct.title,
                'price': e.myProduct.price,
                'quantity': e.quantity,
                'id': e.myProduct.id,
                'imageUrl': e.myProduct.imageUrl
              })
          .toList(),
    });
  }

  fetchOrders() async {
    List<Order> orders = [];
    List<Cart> carts = [];
    QuerySnapshot snapshot =
        await refOrders.doc(userId).collection('ordres').get();
    snapshot.docs.forEach((element) {
      (element['listOfProducts']).forEach((e) {
        Product product =
            Product(imageUrl: e['imageUrl'], title: e['title'], id: e['id']);
        Cart cart = Cart(
          myProduct: product,
          quantity: e['quantity'],
        );
        carts.add(cart);
      });
      Order order = Order(
          amount: double.parse(element['amount']),
          dateTime: DateTime.parse(element['dateTime']),
          listOfProducts: carts);
      orders.add(order);
    });
    return orders;
  }

  Future<String> uploadImageToStorge(imageFile, {String uuid}) async {
    StorageReference firebaseStorageRef =
        // FirebaseStorage.instance.ref().child('uploads/$fileName');
        uuid != null
            ? FirebaseStorage.instance.ref().child('image_$uuid')
            : FirebaseStorage.instance.ref().child('image_$userId');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String photoUrl = await taskSnapshot.ref.getDownloadURL();
    return photoUrl;
  }

  updatePhoto(imageFile) async {
    String url = await uploadImageToStorge(imageFile);
    await refUsers.doc(userId).update({'imageUrl': url});
    return url;
  }

  addProduct(Product product) async {
    await refProducts.doc(product.id).set({
      'desc': product.desc,
      'imageUrl': product.imageUrl,
      'title': product.title,
      'id': product.id,
      'price': product.price
    });
  }

  removeProduct(String id) {
    refProducts.doc(id).delete();
  }
}
