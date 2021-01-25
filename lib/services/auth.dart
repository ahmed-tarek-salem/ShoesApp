import 'package:Ecommerce/services/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future signUp(String email, String password) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = result.user;
      //  await refUsers.doc(firebaseUser.uid).update({
      //   'state': true
      // });
      return firebaseUser.uid;
    } catch (e) {
      return null;
    }
  }

  Future logIn(String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User firebaseUser = result.user;
      return firebaseUser.uid;
    } catch (e) {
      return null;
    }
  }

  logOut() async {
    SharedPref().removeMark();
    await _auth.signOut();
  }
}
