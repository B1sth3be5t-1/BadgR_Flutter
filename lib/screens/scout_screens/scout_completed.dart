import 'package:badgr/classes/firebase_runner.dart';
import 'package:badgr/classes/merit_badge_info.dart';
import 'package:badgr/classes/widgets/custom_accordion_header.dart';
import 'package:badgr/classes/widgets/custom_alert.dart';
import 'package:badgr/classes/widgets/custom_page_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'dart:convert';
import 'package:accordion/accordion.dart';

import '../../classes/themes.dart';

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
                CustomHeader('Completed Badges'),
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
                      QueryDocumentSnapshot? docData = me.value;

                      dynamic data = docData.get('badgeID');
                      int badgeID = data;
                      if (!docData.get('isComplete')) continue;
                      MeritBadge mb = AllMeritBadges.getBadgeByID(badgeID);
                      lis.add(
                        getBadgeSection(mb, context),
                      );
                    }

                    lis.sort((AccordionSection a, AccordionSection b) {
                      return a.index - b.index;
                    });
                    Accordion acc = Accordion(
                      children: lis,
                      headerBackgroundColor:
                          AccordionTheme.headerBackgroundColor,
                      headerBackgroundColorOpened:
                          AccordionTheme.headerBackgroundColorOpened,
                      contentBackgroundColor:
                          AccordionTheme.contentBackgroundColor,
                      contentBorderColor: AccordionTheme.contentBorderColor,
                    );
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

AccordionSection getBadgeSection(MeritBadge mb, BuildContext context) {
  return AccordionSection(
    index: mb.id,
    header: CustomAccordionHeader(
      title: mb.name,
      percent: 1,
    ),
    content: TextButton(
      onPressed: () {
        showDiag(
          'Remove Badge',
          'Are you sure you want to \nremove this badge from \nyour completed list?',
          context,
          ['No', 'Yes'],
          AlertDiagTheme.backgroundColor,
          AlertDiagTheme.textColor,
        ).then((value) {
          if (value == null) return;

          if (value == 'Yes') FirebaseRunner.removeCompletedBadge(mb.id);
        });
      },
      child: Text('Remove Badge'),
    ),
  );
}
