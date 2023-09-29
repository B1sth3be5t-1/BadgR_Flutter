import 'dart:collection';

import 'package:accordion/controllers.dart';
import 'package:badgr/classes/colors_and_themes/color_schemes.g.dart';
import 'package:badgr/classes/colors_and_themes/constants.dart';
import 'package:badgr/classes/widgets/custom_accordion.dart';
import 'package:flutter/material.dart';
import '../../classes/colors_and_themes/themes.dart';
import '../../classes/merit_badge_info.dart';
import '../../classes/widgets/custom_percent_bar.dart';
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

    if (data.length > 1) {
      for (int mi = 1; mi < data.length; mi++) {
        if (mi == 1) {
          lis.add(getBadgeSection(
              AllMeritBadges.getBadgeByID(data.first.entries.first.key),
              data.first.entries.first.value));
        }
        Map m = data[mi];
        if (lis.last.accordionId !=
            AllMeritBadges.getBadgeByID(m.entries.first.key).name)
          for (MapEntry me in m.entries)
            lis.add(
                getBadgeSection(AllMeritBadges.getBadgeByID(me.key), me.value));
      }
    } else if (data.length == 1) {
      lis.add(
        getBadgeSection(
            AllMeritBadges.getBadgeByID(data.first.entries.first.key),
            data.first.entries.first.value),
      );
    }

    lis.sort((a, b) => a.accordionId!.compareTo(b.accordionId!));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            CustomHeader(name, context),
            (lis.length == 0)
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'This scout has no badges added',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .displayMedium
                            ?.copyWith(
                                color: isLight()
                                    ? lightColorScheme.onPrimaryContainer
                                    : darkColorScheme.onPrimaryContainer),
                      ),
                    ),
                  )
                : CustomAccordion(
                    headerBackgroundColor: AccordionTheme.headerBackgroundColor,
                    contentBackgroundColor:
                        AccordionTheme.contentBackgroundColor,
                    contentBorderColor: AccordionTheme.contentBorderColor,
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
    header: CustomPercentageIndicator(
      title: mb.name,
      percent: percent,
    ),
  );
}
