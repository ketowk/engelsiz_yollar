import 'package:firebase_auth/firebase_auth.dart';

import 'database_service.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User currentUser;
  AuthService();

  Future<String> signInWith(String email, String password) async {
    try {
      var result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      var user = result.user;
      return user != null ? null : 'Lütfen tekrar deneyiniz';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Kullanıcı bulunamadı';
      } else if (e.code == 'wrong-password') {
        return 'Yanlış şifre';
      } else {
        return 'Lütfen tekrar deneyiniz';
      }
    }
  }

  // register with email and password
  Future<String> registerWith(
      String email, String password, String name, String surname) async {
    try {
      var result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      var user = result.user;
      currentUser = user;
      await DatabaseService(uid: user.uid).updateUserData(email, name, surname);
      return user != null ? null : 'Lütfen tekrar deneyiniz';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Zayıf Şifre';
      } else if (e.code == 'email-already-in-use') {
        return 'Bu email ile daha önce hesap oluşturulmuş';
      } else {
        return 'Lütfen tekrar deneyiniz';
      }
    } catch (e) {
      return 'Lütfen tekrar deneyiniz';
    }
  }
}
