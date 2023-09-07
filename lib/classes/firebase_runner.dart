import 'dart:async';
import 'package:badgr/classes/themes.dart';
import 'package:badgr/classes/widgets/custom_alert.dart';
import 'package:badgr/screens/scout_screens/scout_main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:badgr/classes/person.dart';

import 'merit_badge_info.dart';

class FirebaseRunner {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static late UserCredential? userCred;
  static Person user = Person.create();
  static Scout? scout = Scout.create();

  static Future<String> loginUserWithEandP(
      String email, String pass, BuildContext c) async {
    try {
      userCred =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      print('Login Error ----------------------------');
      print(e.message);
      if (e.message!.contains('wrong-password') ||
          e.message!.contains('user-not-found') ||
          e.message!.contains('password is invalid')) {
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
      print('Reg Error ----------------------------');
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

  static void sendUser(BuildContext c, String email, {bool b = false}) async {
    var user_info = firestore.collection('user_info').doc(userCred?.user?.uid);

    var info = await user_info.get();
    var data = info.data();

    if (data!.isEmpty) return;

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
    scout = Scout(
        fName: user.fName,
        lName: user.lName,
        a: user.a,
        e: user.e,
        troop: user.troop,
        cred: user.cred);

    Navigator.pushNamed(c, ScoutScreen.screenID, arguments: b);
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

  static Scout? getScout() {
    return scout;
  }

  static Stream<QuerySnapshot> badgesByUserStream() {
    return FirebaseFirestore.instance
        .collection('user_added_badges')
        .where('uid', isEqualTo: userCred?.user!.uid)
        .snapshots();
  }

  static List<MeritBadge> getSearchResults(String s) {
    List<MeritBadge> lis = [];
    for (var e in AllMeritBadges.allBadges.entries) {
      if (e.value.name.toLowerCase().contains(s.toLowerCase()))
        lis.add(e.value);
    }
    return lis;
  }

  static Future<List<Map<int, bool>>> getInProgressBadges(Scout s) async {
    Map<int, bool> retAdded = {};
    Map<int, bool> retCompl = {};
    try {
      var badge_info = FirebaseFirestore.instance
          .collection('user_added_badges')
          .where('uid', isEqualTo: s.cred?.user!.uid);

      var info = await badge_info.get();
      var docs = info.docs;
      for (var d in docs) {
        Map<String, dynamic> data = d.data();
        if (data['inProgress']) retAdded[data['badgeID']] = true;
        if (data['isComplete']) retCompl[data['badgeID']] = true;
      }
    } catch (e) {}

    return [retAdded, retCompl];
  }

  static Future<Map<int, MeritBadge>> setAllBadges() async {
    Map<int, MeritBadge> mbs = Map();

    /* CollectionReference badges =
        FirebaseFirestore.instance.collection('badge_table');

    var info = await badges.get();
    var data = info.docs.toList();
    for (var d in data) {
      mbs[d['id']] = MeritBadge(
          d['id'], d['name'], d['isEagleRequired'], d['numReqs'], Map());
    } */ //This is taking up way too many reads. Will keep merit badges in application instead of in database
    //It would only allow 294 openings of the app before I would run out of reads, not to mention the number of
    //other read transactions that would occur

    for (MeritBadge mb in badges) mbs[mb.id] = mb;
    return mbs;
  }

  static Future<String> updateAccount(Map<String, String> m) async {
    try {
      for (var entry in m.entries) {
        if (entry.key == 'fname')
          FirebaseFirestore.instance
              .collection('user_info')
              .doc('${userCred?.user!.uid}')
              .update({'fname': entry.value});
        if (entry.key == 'lname')
          FirebaseFirestore.instance
              .collection('user_info')
              .doc('${userCred?.user!.uid}')
              .update({'lname': entry.value});
        if (entry.key == 'age')
          FirebaseFirestore.instance
              .collection('user_info')
              .doc('${userCred?.user!.uid}')
              .update({'age': int.parse(entry.value)});
        if (entry.key == 'troop')
          FirebaseFirestore.instance
              .collection('user_info')
              .doc('${userCred?.user!.uid}')
              .update({'troop': int.parse(entry.value)});
      }
    } catch (e) {
      return 'Error';
    }
    return 'Done';
  }

  static Future<String> toggleAddedBadge(int id, bool checked) async {
    try {
      if (!checked)
        FirebaseFirestore.instance
            .collection('user_added_badges')
            .doc('${user.cred?.user!.uid}::$id')
            .delete();
      else {
        Map<String, dynamic> map = {};

        MeritBadge mb = AllMeritBadges.getBadgeByID(id);
        for (int i = 1; i <= mb.numReqs; i++) {
          map[i.toString()] = false;
        }
        FirebaseFirestore.instance
            .collection('user_added_badges')
            .doc('${user.cred?.user!.uid}::$id')
            .set({
          'inProgress': checked,
          'uid': user.cred?.user!.uid,
          'badgeID': id,
          'isComplete': false,
          'requirements': map,
        });
      }
    } catch (e) {
      return 'Error';
    }
    return 'Done';
  }

  static Future<String> toggleCompletedReq(
      int bid, Map<String, dynamic> map, BuildContext c) async {
    try {
      FirebaseFirestore.instance
          .collection('user_added_badges')
          .doc('${user.cred?.user!.uid}::$bid')
          .update({'requirements': map});

      for (MapEntry<String, dynamic> me in map.entries)
        if (!me.value) return 'Done';

      return setCompletedBadge(bid, c);
    } catch (e) {
      print(e);
      return 'Error';
    }
  }

  static Future<String> removeCompletedBadge(int id) async {
    try {
      Map<String, dynamic> map = {};

      MeritBadge mb = AllMeritBadges.getBadgeByID(id);
      for (int i = 1; i <= mb.numReqs; i++) {
        map[i.toString()] = false;
      }

      FirebaseFirestore.instance
          .collection('user_added_badges')
          .doc('${user.cred?.user!.uid}::$id')
          .set({
        'inProgress': true,
        'uid': user.cred?.user!.uid,
        'badgeID': id,
        'isComplete': false,
        'requirements': map,
      });
    } catch (e) {
      return 'Error';
    }
    return 'Done';
  }

  static Future<String> setCompletedBadge(int id, BuildContext c) async {
    try {
      Map<String, dynamic> map = {};

      MeritBadge mb = AllMeritBadges.getBadgeByID(id);
      for (int i = 1; i <= mb.numReqs; i++) {
        map[i.toString()] = true;
      }

      FirebaseFirestore.instance
          .collection('user_added_badges')
          .doc('${user.cred?.user!.uid}::$id')
          .set({
        'inProgress': true,
        'uid': user.cred?.user!.uid,
        'badgeID': id,
        'isComplete': true,
        'requirements': true
      });

      showDiag(
              'Badge Complete',
              'Congratulations! You\'ve \ncompleted a merit badge!',
              c,
              ['Yay!'],
              AlertDiagTheme.backgroundColor,
              AlertDiagTheme.textColor)
          .then((value) => 'Done');
    } catch (e) {
      return 'Error';
    }
    return 'Done';
  }

/*static void inputBadges(List<MeritBadge> b) {
    CollectionReference badges =
        FirebaseFirestore.instance.collection('badge_table');

    for (MeritBadge mb in b) {
      badges.doc('${mb.name}').set({
        'id': mb.id,
        'name': mb.name,
        'numReqs': mb.numReqs,
        'isEagleRequired': mb.isEagleRequired
      });
    }
  } */
}
