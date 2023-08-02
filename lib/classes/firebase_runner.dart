import 'dart:async';

import 'package:badgr/screens/scout_screens/scout_main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:badgr/classes/person.dart';

class FirebaseRunner {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static late UserCredential? userCred;
  static Person user = Person.create();

  static Future<String> loginUserWithEandP(
      String email, String pass, BuildContext c) async {
    try {
      userCred =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      if (e.message!.contains('wrong-password') ||
          e.message!.contains('user-not-found')) {
        return 'wrongEmailPass';
      } else if (e.message!.contains('too-many-requests')) {
        return 'tooMany';
      } else if (e.message!.contains('network-request-failed')) {
        return 'network';
      } else {
        return 'error';
      }
    }
    if (userCred == null) return 'null';

    sendUser(c, email);

    return 'done';
  }

  static Future<String> registerUserWithEandP(String email, String pass,
      String fn, String ln, int t, int a, BuildContext c) async {
    try {
      userCred = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.message!.contains('email-already-in-use')) {
        return 'emailInUse';
      } else if (e.message!.contains('network-request-failed')) {
        return 'network';
      } else {
        return 'error';
      }
    }
    if (userCred == null) return 'null';

    CollectionReference user_info =
        FirebaseFirestore.instance.collection('user_info');
    String res = 'done';

    user_info
        .doc('${userCred?.user!.uid}')
        .set({'age': a, 'email': email, 'fname': fn, 'lname': ln, 'troop': t})
        .then((value) => res = 'done')
        .catchError((error) {
          return 'addInfoError';
        });

    sendUser(c, email);
    return res;
  }

  static void sendUser(BuildContext c, String email) async {
    CollectionReference user_info =
        FirebaseFirestore.instance.collection('user_info');

    var info = await user_info.where('email', isEqualTo: email).get();
    var data = info.docs.toList()[0];

    user = Person(
        fName: data['fname'],
        lName: data['lname'],
        e: email,
        a: data['age'],
        troop: data['troop'],
        cred: userCred);
    if (user.age >= 18) {
      //todo send to SM screen
    }
    Navigator.pushNamed(c, ScoutScreen.screenID);
  }

  static Future<String> resetPass(String em) async {
    try {
      await auth.sendPasswordResetEmail(email: em);
    } on FirebaseAuthException catch (e) {
      if (e.message!.contains('network-request-failed')) {
        return 'network';
      } else if (e.message!.contains('missing-email')) {
        return 'enterEmail';
      } else if (e.message!.contains('user-not-found')) {
        return 'user-not-found';
      }
      return 'error';
    }
    return 'done';
  }

  static void logoutUser() {
    auth.signOut();
  }

  static Person getUser() {
    return user;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> badgesByUserStream(
      String email) {
    return firestore
        .collection('userBadges')
        .where('email', isEqualTo: email)
        .snapshots();
  }
}
