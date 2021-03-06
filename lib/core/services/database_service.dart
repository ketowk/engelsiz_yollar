import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class DatabaseService {
  static DatabaseService instance = DatabaseService();

  final String uid;
  DatabaseService({this.uid});

  UserFromFirebase currentUser;

  //collection reference
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String email, String name, String surname) async {
    return await usersRef.doc(uid).set({
      'uid': uid,
      'email': email,
      'name': name,
      'surname': surname,
    });
  }
}
