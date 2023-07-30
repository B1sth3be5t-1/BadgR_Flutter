import 'package:firebase_auth/firebase_auth.dart';

class Person {
  String fName;
  String lName;
  String e;
  int a;
  int troop;
  UserCredential cred;

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
}
