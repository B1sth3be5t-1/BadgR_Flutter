import 'package:badgr/classes/merit_badge_info.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../classes/firebase_runner.dart';
import '../../classes/widgets/custom_page_header.dart';

class ScoutmasterHome extends StatefulWidget {
  const ScoutmasterHome({super.key});

  @override
  ScoutmasterHomeState createState() => ScoutmasterHomeState();
}

class ScoutmasterHomeState extends State<ScoutmasterHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomHeader('Welcome to BadgR!', context),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseRunner.scoutChangesStream(),
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
                      return Text('');
                    } else if (snapshot.data?.docs.length == 0) {
                      return Text(
                        'You have no Scouts in your troop!',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .displayMedium
                            ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer),
                      );
                    }
                    Map<int, QueryDocumentSnapshot<Object?>> docMap =
                        snapshot.data!.docs.toList().asMap();

                    int numBadges = 0;
                    int numEagle = 0;
                    int numComplete = 0;
                    int numScouts =
                        FirebaseRunner.getScoutmaster()!.scouts.length;

                    for (MapEntry<int, QueryDocumentSnapshot<Object?>> me
                        in docMap.entries) {
                      QueryDocumentSnapshot? docData = me.value;

                      if (docData.get('isComplete'))
                        numComplete++;
                      else
                        numBadges++;

                      MeritBadge mb =
                          AllMeritBadges.getBadgeByID(docData.get('badgeID'));
                      if (mb.isEagleRequired) numEagle++;
                    }

                    return SingleChildScrollView(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'Follow the Navigation Bar on the bottom of the page to begin your journey!',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headlineMedium,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                '• Your troop has $numScouts scout(s) in it',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headlineMedium,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                '• Your Scouts have completed $numComplete merit badge(s)',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headlineMedium,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                '• Your Scouts have $numBadges merit badge(s) in progress',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headlineMedium,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                '• $numEagle of the ${numComplete + numBadges} total badges are required for Eagle Scout',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .headlineMedium,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height:
                                  MediaQuery.of(context).size.height / 2 - 50,
                              child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      'images/app_full_pic_pink.png',
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
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
