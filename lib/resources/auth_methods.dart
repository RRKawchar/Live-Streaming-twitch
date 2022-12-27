import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:live_streaming_pro_2/models/users.dart';

class AuthMethod {
  final _userRef = FirebaseFirestore.instance.collection('users');
  final _auth = FirebaseAuth.instance;

  Future<bool> signUpUser(
    String email,
    String username,
    String password,
  ) async {
    bool res=false;
    try {

      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (cred.user != null) {
        Users users = Users(
          uid: cred.user!.uid,
          username: username.trim(),
          email: email.trim(),
        );

        await _userRef.doc(cred.user!.uid).set(users.toMap());
        res=true;
      }
    } on FirebaseAuthException catch (e) {
      print(e.message!);
    }
    return res;
  }
}
