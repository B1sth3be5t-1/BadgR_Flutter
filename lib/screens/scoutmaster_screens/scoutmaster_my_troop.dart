import 'package:badgr/classes/firebase_runner.dart';
import 'package:badgr/classes/colors_and_themes/themes.dart';
import 'package:badgr/classes/widgets/custom_accordion_section.dart';
import 'package:badgr/classes/widgets/custom_page_header.dart';
import 'package:badgr/screens/scoutmaster_screens/scoutmaster_scout_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../classes/person.dart';
import '../../classes/widgets/custom_accordion.dart';

class ScoutmasterMyTroop extends StatefulWidget {
  const ScoutmasterMyTroop({super.key, required this.sm});

  final Scoutmaster sm;

  @override
  // ignore: library_private_types_in_public_api
  ScoutmasterMyTroopState createState() => ScoutmasterMyTroopState(sm: sm);
}

class ScoutmasterMyTroopState extends State<ScoutmasterMyTroop> {
  ScoutmasterMyTroopState({required this.sm});

  final Scoutmaster sm;
  static final Map<String, List<Map<int, dynamic>>> mapData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              CustomHeader('My Troop Progress'),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseRunner.scoutChangesStream(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData || snapshot.hasError) {
                    return Text('An error has occurred');
                  } else if (snapshot.data?.docs.length == 0) {
                    return Center(
                      child: Text(
                        'None of your scouts have any badges in progress!',
                      ),
                    );
                  }

                  //get map of docSnapshots (aka the added badges)
                  Map<int, QueryDocumentSnapshot<Object?>> docMap =
                      snapshot.data!.docs.toList().asMap();

                  for (MapEntry<int, QueryDocumentSnapshot<Object?>> me
                      in docMap.entries) {
                    QueryDocumentSnapshot? docData = me.value;

                    List<Map<int, dynamic>>? curUID = mapData[docData['uid']];

                    if (curUID == null) {
                      mapData[docData['uid']] = [];
                    }

                    //if docData['requirements'] is a bool and true, then add to completed
                    Map<int, dynamic> map = {};
                    map[docData['badgeID']] = docData['requirements'];
                    mapData[docData['uid']]!.add(map);
                  }

                  List<CustomAccordionSection> lis = [];

                  for (Scout s in sm.scouts) {
                    if (!mapData.containsKey(s.uid)) mapData[s.uid] = [];

                    lis.add(
                      CustomAccordionSection(
                        headerBackgroundColor:
                            AccordionTheme.customAccBackColor,
                        header: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Route r = MaterialPageRoute(
                                    builder: (context) => ScoutmasterScoutView(
                                        data: mapData[s.uid]!, name: s.name));

                                Navigator.push(context, r);
                              },
                              icon: Icon(Icons.arrow_forward_outlined),
                              tooltip: 'Open',
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              s.name,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headlineLarge,
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return CustomAccordion(
                    children: lis,
                    headerBackgroundColor: AccordionTheme.headerBackgroundColor,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
