import 'dart:collection';

import 'package:badgr/classes/firebase_runner.dart';
import 'package:badgr/classes/merit_badge_info.dart';
import 'package:badgr/classes/widgets/custom_accordion.dart';
import 'package:badgr/classes/widgets/custom_percent_bar.dart';
import 'package:badgr/classes/widgets/custom_accordion_section.dart';
import 'package:badgr/classes/widgets/custom_page_header.dart';
import 'package:badgr/classes/widgets/custom_req_checkbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:accordion/accordion.dart';

import '../../classes/colors_and_themes/color_schemes.g.dart';
import '../../classes/colors_and_themes/constants.dart';
import '../../classes/colors_and_themes/themes.dart';
import '../../classes/widgets/custom_alert.dart';

class ScoutMyBadges extends StatefulWidget {
  const ScoutMyBadges({super.key});

  @override
  // ignore: library_private_types_in_public_api
  ScoutMyBadgesState createState() => ScoutMyBadgesState();
}

class ScoutMyBadgesState extends State<ScoutMyBadges> {
  bool showSpinner = false;

  static Map<int, Map<String, dynamic>> reqMap = {};
  static List<int> changed = [];
  static bool isTodo = false;

  final _headerStyle = TextStyle(
      color: isLight() ? kColorDarkBlue : kColorDarkBlue,
      fontSize: 20,
      fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    isTodo = false;
    return Scaffold(
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              CustomHeader('My Badges', context),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseRunner.badgesByUserStream(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Container(
                        height: 100,
                        child: ModalProgressHUD(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          inAsyncCall: true,
                          child: Text(''),
                        ),
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.hasError) {
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

                    if (docData.get('isComplete') || !docData.get('inProgress'))
                      continue;

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
                    return a.accordionId!.compareTo(b.accordionId!);
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
                        AccordionTheme.headerBackgroundColor(),
                    headerBackgroundColorOpened:
                        AccordionTheme.headerBackgroundColorOpened(),
                    contentBackgroundColor:
                        AccordionTheme.contentBackgroundColor(),
                    contentBorderColor: AccordionTheme.contentBorderColor(),
                  );

                  return acc;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        child: Icon(
          Icons.add,
          color: isLight()
              ? lightColorScheme.onTertiary
              : darkColorScheme.onTertiary,
        ),
        tooltip: 'Submit',
        onPressed: () async {
          if (changed.isEmpty) {
            showDiag(
                'Error',
                'Make some requirement updates before submitting!',
                context,
                ['Ok']);
            return;
          }
          String str = "";
          try {
            str = await FirebaseRunner.toggleCompletedReqs(
                changed, reqMap, context);
            if (str != "Done") throw Exception('Error!');
          } catch (e) {
            showDiag(
                'Error',
                'An unknown error has occurred. \nPlease try again',
                context,
                ['Ok']);
            return;
          }
        },
      ),
    );
  }

  static void updateReqMap(
      {required int bid, required int id, required bool compl}) {
    reqMap[bid]?[id.toString()] = compl;
  }

  static Map<String, dynamic> getReqMap({required int bid}) {
    return reqMap[bid]!;
  }

  static void addChangedInt(int bid) {
    changed.add(bid);
  }

  static void clearChanged() {
    changed = [];
  }

  static bool getChangedBool() {
    return changed.isNotEmpty;
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
    int reqNum = me.key;

    String req = AllMeritBadges.allBadges[mb.id]!.reqs[reqNum] ?? 'todo';

    if (req == 'todo') ScoutMyBadgesState.isTodo = true;

    lis.add(
      CustomAccordionSection(
        headerBorderColor: AccordionTheme.customAccTextColor(),
        headerBorderWidth: 10,
        headerBorderColorOpened: AccordionTheme.customAccTextColor(),
        headerBorderRadius: 10,
        headerBackgroundColor: AccordionTheme.customAccBackColor(),
        header: Row(
          children: [
            CustomReqCheckbox(
                bid: mb.id, id: reqNum, completed: me.value, c: context),
            Expanded(
              child: Text(
                reqNum.toString() + ': ' + req,
                softWrap: true,
                style: TextStyle(
                  color: AccordionTheme.customAccTextColor(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    if (reqNum != mb.numReqs)
      lis.add(
        CustomAccordionSection(
          headerBorderColor: AccordionTheme.customAccTextColor(),
          headerBorderWidth: 10,
          headerBorderColorOpened: AccordionTheme.customAccTextColor(),
          headerBorderRadius: 10,
          headerBackgroundColor: AccordionTheme.customAccBackColor(),
          header: SizedBox(
            child: Padding(
              padding: EdgeInsets.only(top: 2, bottom: 2, right: 20, left: 20),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AccordionTheme.customAccTextColor(),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            height: 14,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      );
  }

  double percent = count * 1.0 / mb.numReqs;
  percent = double.parse(percent.toStringAsFixed(2));

  return AccordionSection(
    accordionId: mb.name,
    index: mb.id,
    header: CustomPercentageIndicator(
      axis: MainAxisAlignment.start,
      title: mb.name,
      percent: percent,
    ),
    content: CustomAccordion(
      contentBorderColor: AccordionTheme.customAccTextColor(),
      contentBorderWidth: 5,
      headerBackgroundColor: AccordionTheme.headerBackgroundColor(),
      children: lis,
    ),
  );
}
