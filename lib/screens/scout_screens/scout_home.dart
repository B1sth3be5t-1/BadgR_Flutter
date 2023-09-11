import 'package:badgr/classes/constants.dart';
import 'package:badgr/classes/merit_badge_info.dart';
import 'package:badgr/classes/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../classes/firebase_runner.dart';
import '../../classes/widgets/custom_page_header.dart';

class ScoutHome extends StatefulWidget {
  const ScoutHome({super.key});

  @override
  ScoutHomeState createState() => ScoutHomeState();
}

class ScoutHomeState extends State<ScoutHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              CustomHeader('Welcome to BadgR!'),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseRunner.badgesByUserStream(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData || snapshot.hasError) {
                    return Text('');
                  } else if (snapshot.data?.docs.length == 0) {
                    return Text('You have no badges added!');
                  }
                  Map<int, QueryDocumentSnapshot<Object?>> docMap =
                      snapshot.data!.docs.toList().asMap();

                  int numBadges = 0;
                  int numEagle = 0;
                  int complReqs = 0;
                  int totalReqs = 0;

                  for (MapEntry<int, QueryDocumentSnapshot<Object?>> me
                      in docMap.entries) {
                    QueryDocumentSnapshot? docData = me.value;

                    if (docData.get('isComplete')) continue;

                    numBadges++;
                    MeritBadge mb =
                        AllMeritBadges.getBadgeByID(docData.get('badgeID'));

                    if (mb.isEagleRequired) numEagle++;

                    for (MapEntry<String, dynamic> me in docData
                        .get('requirements')
                        .entries) if (me.value) complReqs++;

                    totalReqs += mb.numReqs;
                  }

                  if (totalReqs == 0) return Text('You have no badges added!');

                  double percent = complReqs * 1.0 / totalReqs;

                  Row r3 = Row(
                    children: [
                      Expanded(
                        child: Text(
                            'Your percentage completion of saved badges is: '),
                        flex: 1,
                      ),
                      Expanded(
                        flex: 1,
                        child: LinearPercentIndicator(
                          center: percent < .45
                              ? Text(
                                  '${(percent * 100).toInt()}%',
                                )
                              : Text(
                                  '${(percent * 100).toInt()}%',
                                  style: TextStyle(color: Colors.white),
                                ),
                          progressColor: linProgTheme.progressColor,
                          backgroundColor: linProgTheme.backgroundColor,
                          percent: percent,
                          lineHeight: 20,
                          barRadius: Radius.circular(7.5),
                          animation: true,
                        ),
                      )
                    ],
                  );

                  return Column(
                    children: [
                      Text(
                        'Follow the Navigation Bar on the bottom \nof the page to begin your journey!',
                        textAlign: TextAlign.center,
                      ),
                      Text('You have $numBadges merit badge(s) in progress'),
                      Text('$numEagle of those are required for Eagle Scout'),
                      r3,
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset('images/app_full_pic_pink.png'),
                        ),
                      ),
                    ],
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
