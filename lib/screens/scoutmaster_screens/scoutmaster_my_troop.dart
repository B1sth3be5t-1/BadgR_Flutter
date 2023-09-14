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
import '../../classes/widgets/custom_alert.dart';

class ScoutmasterMyTroop extends StatefulWidget {
  const ScoutmasterMyTroop({super.key});

  @override
  // ignore: library_private_types_in_public_api
  ScoutmasterMyTroopState createState() => ScoutmasterMyTroopState();
}

class ScoutmasterMyTroopState extends State<ScoutmasterMyTroop> {
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
                CustomHeader('My Troop Progress'),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseRunner.scoutChangesStream(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData || snapshot.hasError) {
                      return Text('todo');
                    } else if (snapshot.data?.docs.length == 0) {
                      return Center(
                        child: Text(
                          'Go add some badges!',
                        ),
                      );
                    }

                    //get map of docSnapshots (aka the added badges)
                    Map<int, QueryDocumentSnapshot<Object?>> docMap =
                        snapshot.data!.docs.toList().asMap();

                    for (var me in docMap.entries) {
                      for (MapEntry<int, QueryDocumentSnapshot<Object?>> me
                          in docMap.entries) {
                        QueryDocumentSnapshot? docData = me.value;

                        print(docData.toString());
                      }
                    }

                    return Text('');
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
