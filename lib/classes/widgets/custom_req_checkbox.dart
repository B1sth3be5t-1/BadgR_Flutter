import 'package:badgr/screens/scout_screens/scout_my_badges.dart';
import 'package:flutter/material.dart';
import 'package:badgr/classes/constants.dart';
import 'package:badgr/classes/widgets/custom_alert.dart';
import 'package:badgr/classes/firebase_runner.dart';

class CustomReqCheckbox extends StatefulWidget {
  CustomReqCheckbox(
      {required this.bid,
      required this.id,
      required this.completed,
      required this.c});

  final int id;
  final int bid;
  final bool completed;
  final BuildContext c;

  _checkReqBox createState() =>
      _checkReqBox(bid: bid, id: id, completed: completed, c: c);

  int getId() {
    return id;
  }
}

class _checkReqBox extends State<CustomReqCheckbox> {
  _checkReqBox(
      {required this.id,
      required this.completed,
      required this.bid,
      required this.c});

  final int id;
  final int bid;
  bool completed;
  final BuildContext c;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: completed,
      onChanged: (val) async {
        ScoutMyBadgesState.updateMap(bid: bid, id: id, compl: val!);
        String str = "";
        try {
          str = await FirebaseRunner.toggleCompletedReq(
              bid, ScoutMyBadgesState.getMap(bid: bid), c);
          if (str != "Done") throw Exception('Error!');
        } catch (e) {
          showDiag('Error', 'An unknown error has occurred. \nPlease try again',
              context, ['Ok'], kColorXLightBlue, kColorDarkBlue);
          //todo fix
          return;
        }
        setState(() {
          completed = val;
        });
      },
    );
  }
}
