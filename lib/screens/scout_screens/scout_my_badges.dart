import 'dart:collection';

import 'package:badgr/classes/firebase_runner.dart';
import 'package:badgr/classes/merit_badge_info.dart';
import 'package:badgr/classes/widgets/custom_accordion.dart';
import 'package:badgr/classes/widgets/custom_accordion_header.dart';
import 'package:badgr/classes/widgets/custom_accordion_section.dart';
import 'package:badgr/classes/widgets/custom_page_header.dart';
import 'package:badgr/classes/widgets/custom_req_checkbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:accordion/accordion.dart';

import '../../classes/constants.dart';
import '../../classes/themes.dart';

class ScoutMyBadges extends StatefulWidget {
  const ScoutMyBadges({super.key});

  static String screenID = 'scoutMainScreen';

  @override
  // ignore: library_private_types_in_public_api
  ScoutMyBadgesState createState() => ScoutMyBadgesState();
}

class ScoutMyBadgesState extends State<ScoutMyBadges> {
  bool showSpinner = false;

  static Map<int, Map<String, dynamic>> reqMap = {};
  static int opened = 0;

  final _headerStyle = TextStyle(
      color: isLight() ? kColorDarkBlue : kColorDarkBlue,
      fontSize: 20,
      fontWeight: FontWeight.bold);

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
                CustomHeader('My Badges'),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseRunner.badgesByUserStream(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData || snapshot.hasError) {
                      return Text('todo');
                    } else if (snapshot.data?.docs.length == 0) {
                      return Center(
                        child: Text(
                          'Go add some badges!',
                          style: _headerStyle,
                        ),
                      );
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

                      if (docData.get('isComplete') ||
                          !docData.get('inProgress')) continue;
                      MeritBadge mb = AllMeritBadges.getBadgeByID(badgeID);
                      lis.add(
                        getBadgeSection(
                          mb,
                          context,
                          docData.get('requirements'),
                        ),
                      );

                      reqMap[mb.id] = docData.get('requirements');
                    }

                    lis.sort((AccordionSection a, AccordionSection b) {
                      return a.index - b.index;
                    });

                    if (lis.isEmpty)
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Go add some badges!',
                            style: _headerStyle,
                          ),
                        ),
                      );

                    Accordion acc = Accordion(
                      children: lis,
                      openAndCloseAnimation: false,
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

  static void updateMap(
      {required int bid, required int id, required bool compl}) {
    reqMap[bid]?[id.toString()] = compl;
  }

  static Map<String, dynamic> getMap({required int bid}) {
    return reqMap[bid]!;
  }

  static void updateOpened(int i) {
    opened = i;
  }
}

AccordionSection getBadgeSection(
    MeritBadge mb, BuildContext context, LinkedHashMap<String, dynamic> map) {
  List<CustomAccordionSection> lis = [];

  final sorted = SplayTreeMap<String, dynamic>.from(
      map, (a, b) => int.parse(a) - int.parse(b));

  Map<int, bool> m = {};

  int count = 0;

  sorted.forEach((key, value) {
    m[int.parse(key)] = value;
    if (value) count++;
  });

  for (MapEntry<int, bool> me in m.entries) {
    lis.add(
      CustomAccordionSection(
        header: Row(
          children: [
            CustomReqCheckbox(
                bid: mb.id, id: me.key, completed: me.value, c: context),
            Text(me.key.toString() + ': ' + me.value.toString()),
          ],
        ),
      ),
    );
  }

  double percent = count * 1.0 / mb.numReqs;
  percent = double.parse(percent.toStringAsFixed(2));

  return AccordionSection(
    onOpenSection: () => ScoutMyBadgesState.updateOpened(mb.id),
    onCloseSection: () => ScoutMyBadgesState.updateOpened(0),
    isOpen: mb.id == ScoutMyBadgesState.opened,
    index: mb.id,
    header: CustomAccordionHeader(
      title: mb.name,
      percent: percent,
    ),
    content: CustomAccordion(
      headerBackgroundColor: AccordionTheme.headerBackgroundColor,
      children: lis,
    ),
  );
}
