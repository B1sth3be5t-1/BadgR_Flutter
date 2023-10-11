import 'package:BadgR/screens/scout_screens/scout_my_badges.dart';
import 'package:flutter/material.dart';

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
        ScoutMyBadgesState.updateReqMap(bid: bid, id: id, compl: val!);
        ScoutMyBadgesState.addChangedInt(bid);
        setState(() {
          completed = val;
        });
      },
    );
  }
}
