import 'package:accordion/controllers.dart';
import 'package:badgr/classes/constants.dart';
import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:badgr/classes/widgets/custom_header.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget(
      {required this.BGcolor,
      required this.textColor,
      required this.map,
      required this.headerStyle});

  final Color BGcolor;
  final Color textColor;
  final Map<String, Widget> map;
  final TextStyle headerStyle;

  @override
  // ignore: library_private_types_in_public_api
  _SettingsWidgetState createState() => _SettingsWidgetState(
      BGcolor: BGcolor,
      textColor: textColor,
      map: map,
      headerStyle: headerStyle);
}

class _SettingsWidgetState extends State<SettingsWidget> {
  _SettingsWidgetState(
      {required this.BGcolor,
      required this.textColor,
      required this.map,
      required this.headerStyle});

  final Color BGcolor;
  final Color textColor;
  final Map<String, Widget> map;
  late final List<AccordionSection> list;
  final TextStyle headerStyle;

  @override
  void initState() {
    super.initState();
    list = getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        child: ListView(
          children: [
            CustomHeader('Settings', kColorDarkBlue),
            Accordion(
              maxOpenSections: 1,
              headerBackgroundColorOpened: kColorLightBlue,
              headerBackgroundColor: kColorLightPink,
              contentBorderColor: kColorLightBlue,
              scaleWhenAnimating: true,
              openAndCloseAnimation: true,
              headerPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
              sectionClosingHapticFeedback: SectionHapticFeedback.light,
              children: list,
            ),
          ],
        ),
      ),
    );
  }

  List<AccordionSection> getList() {
    List<AccordionSection> lis = [];
    for (var entry in map.entries) {
      lis.add(AccordionSection(
          header: Text(
            entry.key,
            style: headerStyle,
          ),
          content: entry.value));
    }
    return lis;
  }
}
