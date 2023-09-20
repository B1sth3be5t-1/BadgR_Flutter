import 'package:firebase_auth/firebase_auth.dart';

class Person {
  String fName;
  String lName;
  String e;
  int a;
  int troop;
  UserCredential? cred;
  String uid;

  static final Person def = Person(
      fName: 'Test',
      lName: 'Person',
      e: 'test1@gmail.com',
      a: 19,
      troop: 39,
      cred: null,
      uid: 'test');

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

  Person(
      {required this.fName,
      required this.lName,
      required this.e,
      required this.a,
      required this.troop,
      required this.cred,
      required this.uid});

  factory Person.create() {
    return def;
  }
}

class Scout extends Person {
  Scout(
      {required super.fName,
      required super.lName,
      required super.troop,
      required super.cred,
      required super.e,
      required super.a,
      required super.uid});

  static final Scout def = Scout(
      fName: 'Test',
      lName: 'Person',
      e: 'test1@gmail.com',
      a: 19,
      troop: 39,
      cred: null,
      uid: 'test');

  factory Scout.create() {
    return def;
  }
}

class Scoutmaster extends Person {
  Scoutmaster(
      {required super.fName,
      required super.lName,
      required super.troop,
      required super.cred,
      required super.e,
      required super.a,
      required this.scouts,
      required super.uid});

  List<Scout> scouts;

  static final Scoutmaster def = Scoutmaster(
      fName: 'Test',
      lName: 'Person',
      e: 'test2@gmail.com',
      a: 19,
      troop: 39,
      cred: null,
      scouts: [],
      uid: 'test');

  factory Scoutmaster.create() {
    return def;
  }
}
