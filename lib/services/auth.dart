import 'package:firebase_auth/firebase_auth.dart';
import 'package:productivity_app/models/myAppUser.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyAppUser? _userFromFirebaseUser(User? user) {
    return user != null ? MyAppUser(uid: user.uid, email: user.email) : null;
  }

  Future registerFirebaseUser(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  Future loginFirebaseUser(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOutFirebaseUser() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<MyAppUser?> get user =>
      _auth.authStateChanges().map(_userFromFirebaseUser);
}
