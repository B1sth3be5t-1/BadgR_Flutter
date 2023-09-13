import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:badgr/classes/widgets/custom_page_header.dart';
import 'package:badgr/classes/themes.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({required this.map, required this.headerStyle});

  final Map<String, Widget> map;
  final TextStyle? headerStyle;

  @override
  // ignore: library_private_types_in_public_api
  _SettingsWidgetState createState() =>
      _SettingsWidgetState(map: map, headerStyle: headerStyle);
}

class _SettingsWidgetState extends State<SettingsWidget> {
  _SettingsWidgetState({required this.map, required this.headerStyle});

  final Map<String, Widget> map;
  late final List<AccordionSection> list;
  final TextStyle? headerStyle;

  @override
  void initState() {
    super.initState();
    list = getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ListView(
          children: [
            CustomHeader('Settings'),
            Accordion(
              contentBackgroundColor: AccordionTheme.contentBackgroundColor,
              maxOpenSections: 1,
              headerBackgroundColorOpened:
                  AccordionTheme.headerBackgroundColorOpened,
              headerBackgroundColor: AccordionTheme.headerBackgroundColor,
              contentBorderColor: AccordionTheme.contentBorderColor,
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
      lis.add(
        AccordionSection(
            header: Text(
              entry.key,
              style: headerStyle,
            ),
            content: entry.value),
      );
    }
    return lis;
  }
}
