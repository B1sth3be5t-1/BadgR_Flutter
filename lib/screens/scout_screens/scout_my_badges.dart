import 'package:badgr/classes/constants.dart';
import 'package:badgr/classes/firebase_runner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../classes/person.dart';

class ScoutMyBadges extends StatefulWidget {
  const ScoutMyBadges({super.key});
  static String screenID = 'scoutMainScreen';

  @override
  // ignore: library_private_types_in_public_api
  _ScoutMyBadges createState() => _ScoutMyBadges();
}

class _ScoutMyBadges extends State<ScoutMyBadges> {
  late Person user;
  bool showSpinner = false;
  late final stream;

  @override
  void initState() {
    super.initState();
    user = FirebaseRunner.getUser();
    stream = FirebaseRunner.badgesByUserStream(user.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: SizedBox.expand(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Center(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: stream,
              builder: (context, snapshot) {
                List<Text> wid = [];
                if (snapshot.hasData) {
                  final badges = snapshot.data?.docs;
                  for (var badge in badges!) {
                    final info = badge.data();
                    wid.add(Text(info['badgeName']));
                  }
                }
                return Column(children: wid,);
              },
            ),
          ),
          ),
        ),
      );

  }

}
