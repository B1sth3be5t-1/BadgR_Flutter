import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ScoutScreen extends StatefulWidget {
  const ScoutScreen({super.key});
  static String screenID = 'scoutHomeScreen';

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ScoutScreen> {
  final _auth = FirebaseAuth.instance;
  late User user;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final u = _auth.currentUser;
      user = u!;
      print(user.email);
    } catch (e) {
      print(e);
      //todo more exception handling
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white54,
    );
  }
}
