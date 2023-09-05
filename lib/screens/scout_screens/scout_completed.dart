import 'package:badgr/classes/constants.dart';
import 'package:badgr/classes/firebase_runner.dart';
import 'package:badgr/classes/merit_badge_info.dart';
import 'package:badgr/classes/widgets/custom_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'dart:convert';
import 'package:accordion/accordion.dart';
import 'package:accordion/accordion_section.dart';

class ScoutCompleted extends StatefulWidget {
  const ScoutCompleted({super.key});

  static String screenID = 'scoutMainScreen';

  @override
  // ignore: library_private_types_in_public_api
  _ScoutCompleted createState() => _ScoutCompleted();
}

class _ScoutCompleted extends State<ScoutCompleted> {
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                CustomHeader('Completed Badges', kColorDarkBlue),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseRunner.badgesByUserStream(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData || snapshot.hasError) {
                      return Text('nodata');
                    } else if (snapshot.data?.docs.length == 0) {
                      //todo no badges
                    }

                    List<AccordionSection> lis = [];

                    //get map of docSnapshots (aka the added badges)
                    Map<int, QueryDocumentSnapshot<Object?>> docMap =
                        snapshot.data!.docs.toList().asMap();

                    for (MapEntry<int, QueryDocumentSnapshot<Object?>> me
                        in docMap.entries) {
                      Object? docData = me.value.data();
                      String jsonStr = docData
                          .toString()
                          .replaceAll(RegExp('{'), '{"')
                          .replaceAll(RegExp(': '), '": "')
                          .replaceAll(RegExp(', '), '", "')
                          .replaceAll(RegExp('}'), '"}');

                      dynamic data = jsonDecode(jsonStr);
                      int badgeID = int.parse(data['badgeID']);
                      if (data['isComplete'] != 'true') continue;
                      MeritBadge mb = AllMeritBadges.getBadgeByID(badgeID);
                      lis.add(
                        getBadgeSection(mb),
                      );
                    }

                    lis.sort((AccordionSection a, AccordionSection b) {
                      return a.index - b.index;
                    });
                    Accordion acc = Accordion(children: lis);
                    return acc;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

AccordionSection getBadgeSection(MeritBadge mb) {
  return AccordionSection(
    index: mb.id,
    header: Text(
      mb.name,
      style: TextStyle(color: kColorXDarkBlue),
    ),
    content: Text('todo'),
  );
}
