import 'package:badgr/classes/constants.dart';
import 'package:badgr/classes/firebase_runner.dart';
import 'package:badgr/classes/person.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ScoutMyBadges extends StatefulWidget {
  const ScoutMyBadges({super.key});
  static String screenID = 'scoutMainScreen';

  @override
  // ignore: library_private_types_in_public_api
  _ScoutMyBadges createState() => _ScoutMyBadges();
}

class _ScoutMyBadges extends State<ScoutMyBadges> {
  final Person user = Person.create(); //todo FirebaseRunner.getUser();
  bool showSpinner = false;
  final stream =
      FirebaseRunner.badgesByUserStream(FirebaseRunner.getUser().email);

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
                List<_BadgeView> wid = [];
                if (!snapshot.hasData) {
                  return Text('nodata');
                } else if (snapshot.data?.docs.length == 0) {
                  //todo no badges
                }
                print(snapshot.data?.docs.length);
                final badges = snapshot.data?.docs;
                for (var badge in badges!) {
                  final info = badge.data();
                  //todo get completed reqs and all reqs, auto populate
                  //todo badgeID, reqText, reqNum
                  wid.add(_BadgeView(
                      reqText: info['badgeName'],
                      badgeID: 0,
                      reqNum: 0,
                      initState: false));
                }

                return ListView(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  children: wid,
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(10),
        child: FloatingActionButton(
          onPressed: () {
            //todo update
          },
          backgroundColor: kColorBlue,
          child: Icon(
            Icons.add,
            color: kColorDarkBlue,
          ),
          hoverColor: kColorLightBlue,
          tooltip: 'Submit',
        ),
      ),
    );
  }
}

class _BadgeView extends StatefulWidget {
  const _BadgeView(
      {required this.badgeID,
      required this.reqNum,
      required this.reqText,
      required this.initState});

  final String reqText;
  final int badgeID;
  final int reqNum;
  final bool initState;

  @override
  State<StatefulWidget> createState() {
    return _BadgeViewState(
        reqNum: reqNum, reqText: reqText, badgeID: badgeID, checked: initState);
  }
}

class _BadgeViewState extends State<_BadgeView> {
  _BadgeViewState(
      {required this.badgeID,
      required this.reqNum,
      required this.reqText,
      required this.checked});

  bool checked;
  final String reqText;
  final int badgeID;
  final int reqNum;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Material(
        color: kColorLightPink,
        child: Row(
          children: [
            Checkbox(
              value: checked,
              onChanged: (val) {
                setState(() {
                  checked = val!;
                });
              },
              activeColor: kColorBlue,
              checkColor: Colors.white,
              hoverColor: kColorBlue,
              splashRadius: 15,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              reqText,
              style: TextStyle(color: kColorXDarkBlue),
            )
          ],
        ),
      ),
    );
  }
}
