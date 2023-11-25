import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_app/view%20model/local_storage.dart';

import '../models/user_model.dart';

class FireBaseMethods with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> signup(String name, String password, String email) async {
    try {
      UserCredential userData = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel u = UserModel(
        id: userData.user!.uid,
        name: name,
        email: email,
        role: 'user',
        profileImage: '',
        phone: '',
        createDate: DateTime.now(),
        updateDate: DateTime.now(),
      );
      await _firestore.collection('user').doc(userData.user!.uid).set(
            u.toMap(),
          );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> login(Map<String, String> user) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: user['email']!,
        password: user['password']!,
      );
      print(_auth.currentUser!.uid);
      UserModel u = await getUserData(_auth.currentUser!.uid);
      await LocalStorage().setUser(u);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUserData(String id) async {
    DocumentSnapshot doc = await _firestore.collection('user').doc(id).get();
    return UserModel.fromMap(doc.data() as Map<String, dynamic>);
  }
}
