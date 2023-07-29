import 'package:badgr/classes/constants.dart';
import 'package:badgr/screens/scout_screens/scout_home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRunner {
  static final auth = FirebaseAuth.instance;
  static var user;

  static Future<String> loginUserWithEandP(
      String email, String pass, BuildContext c) async {
    try {
      user =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      if (e.message!.contains('wrong-password') ||
          e.message!.contains('user-not-found')) {
        return 'wrongEmailPass';
      } else if (e.message!.contains('too-many-requests')) {
        return 'tooMany';
      } else {
        return 'error';
      }
    }
    if (user == null) return 'null';

    _sendUser(c);

    return 'done';
  }

  static Future<String> registerUserWithEandP(String email, String pass,
      String fn, String ln, int t, int a, BuildContext c) async {
    try {
      user = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.message!.contains('email-already-in-use')) {
        return 'emailInUse';
      } else {
        return 'error';
      }
    }
    if (user == null) return 'null';

    //todo other firestore stuff

    _sendUser(c);
    return 'done';
  }

  static dynamic getUser() {
    if (user == null) throw const FormatException('An error occurred');
    return user;
  }

  static void _sendUser(BuildContext c) {
    //todo check age and send to respective screen
    Navigator.pushNamed(c, ScoutScreen.screenID);
  }
}
