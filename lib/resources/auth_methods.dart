import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:live_streaming_pro_2/models/users.dart';
import 'package:live_streaming_pro_2/provider/user_provider.dart';
import 'package:live_streaming_pro_2/utils/utils.dart';
import 'package:provider/provider.dart';

class AuthMethod {
  final _userRef = FirebaseFirestore.instance.collection('users');
  final _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>?> getCurrentUser(String? uid) async {
    if (uid != null) {
      final snap = await _userRef.doc(uid).get();
      return snap.data();
    }
    return null;
  }

  Future<bool> signUpUser(
    BuildContext context,
    String email,
    String username,
    String password,
  ) async {
    bool res = false;
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
        Provider.of<UserProvider>(context, listen: false).setUser(users);
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      showSnakBar(context, e.message!);
    }
    return res;
  }

  Future<bool> loginUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    bool res=false;
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (cred.user != null) {
        Provider.of<UserProvider>(context,listen: false).setUser(
          Users.fromMap(
            await getCurrentUser(cred.user!.uid) ?? {},
          ),
        );
        res = true;

      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      showSnakBar(context, e.message!);
    }
    return res;
  }
}
