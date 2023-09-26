import 'dart:collection';

import 'package:accordion/controllers.dart';
import 'package:badgr/classes/colors_and_themes/constants.dart';
import 'package:badgr/classes/widgets/custom_accordion.dart';
import 'package:flutter/material.dart';
import '../../classes/merit_badge_info.dart';
import '../../classes/widgets/custom_accordion_header.dart';
import '../../classes/widgets/custom_accordion_section.dart';
import '../../classes/widgets/custom_page_header.dart';

class ScoutmasterScoutView extends StatelessWidget {
  const ScoutmasterScoutView({required this.data, required this.name});

  static final String screenID = '/scoutmasterScoutView';

  final List<Map<int, dynamic>> data;
  final String name;

  @override
  Widget build(BuildContext context) {
    List<CustomAccordionSection> lis = [];
    for (Map m in data)
      for (MapEntry me in m.entries)
        lis.add(getBadgeSection(AllMeritBadges.getBadgeByID(me.key), me.value));

    lis.sort((a, b) => a.accordionId!.compareTo(b.accordionId!));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            CustomHeader(name),
            (lis.length == 0)
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'This scout has no badges added',
                        style: Theme.of(context).primaryTextTheme.displayMedium,
                      ),
                    ),
                  )
                : CustomAccordion(
                    scrollIntoViewOfItems: ScrollIntoViewOfItems.slow,
                    disableScrolling: false,
                    children: lis,
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back_outlined,
          color: Colors.white,
        ),
        tooltip: 'Go back',
        backgroundColor: kColorDarkBlue,
        hoverColor: kColorBlue,
      ),
    );
  }
}

CustomAccordionSection getBadgeSection(MeritBadge mb, dynamic map) {
  double percent;
  if (map.runtimeType == bool && map)
    percent = 1;
  else {
    int count = 0;
    for (MapEntry me in map.entries) if (me.value) count++;

    percent = count * 1.0 / mb.numReqs;
  }

  percent = double.parse(percent.toStringAsFixed(2));

  return CustomAccordionSection(
    accordionId: mb.name,
    header: CustomAccordionHeader(
      title: mb.name,
      percent: percent,
    ),
  );
}
