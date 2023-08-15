import 'package:firebase_auth/firebase_auth.dart';

import 'merit_badge_info.dart';

class Person {
  String fName;
  String lName;
  String e;
  int a;
  int troop;
  UserCredential? cred;

  static final Person def = Person(
      fName: 'Test',
      lName: 'Person',
      e: 'test1@gmail.com',
      a: 19,
      troop: 39,
      cred: null);

  String get name {
    return fName + ' ' + lName;
  }

  int get troopNum {
    return troop;
  }

  int get age {
    return a;
  }

  String get email {
    return e;
  }

  Person({
    required this.fName,
    required this.lName,
    required this.e,
    required this.a,
    required this.troop,
    required this.cred,
  });

  factory Person.create() {
    return def;
  }
}

class Scout extends Person {
  Map<String, Map<int, bool>> inProgressReqs = Map();
  List<MeritBadge> completed = [];

  Scout(
      {required super.fName,
      required super.lName,
      required super.troop,
      required super.cred,
      required super.e,
      required super.a});

  static final Scout def = Scout(
      fName: 'Test',
      lName: 'Person',
      e: 'test1@gmail.com',
      a: 19,
      troop: 39,
      cred: null);

  factory Scout.create() {
    return def;
  }
}
