import 'dart:js_interop';

import 'package:badgr/classes/colors_and_themes/themes.dart';
import 'package:accordion/accordion.dart';
import 'package:badgr/classes/colors_and_themes/constants.dart';
import 'package:badgr/classes/merit_badge_info.dart';
import 'package:badgr/classes/firebase_runner.dart';
import 'package:flutter/material.dart';
import 'package:badgr/classes/widgets/custom_input.dart';
import 'package:badgr/classes/widgets/custom_page_header.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:badgr/classes/widgets/custom_search_checkbox.dart';

import '../../classes/colors_and_themes/color_schemes.g.dart';

class ScoutSearch extends StatefulWidget {
  ScoutSearch({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ScoutSearchState createState() => _ScoutSearchState();
}

class _ScoutSearchState extends State<ScoutSearch> {
  final _headerStyle = isLight()
      ? kThemeLight.primaryTextTheme.displaySmall
      : kThemeDark.primaryTextTheme.displaySmall;
  final _searchStyle = isLight()
      ? kThemeLight.primaryTextTheme.displayMedium
          ?.copyWith(color: lightColorScheme.onPrimaryContainer)
      : kThemeDark.primaryTextTheme.displayMedium
          ?.copyWith(color: darkColorScheme.onPrimaryContainer);
  final TextEditingController _tec = TextEditingController();
  static Map<int, bool> bools = {};
  static Map<int, bool> completes = {};

  Widget Acc = Text('');
  bool showSpinner = false;
  bool fromButton = false;

  @override
  void initState() {
    super.initState();

    FirebaseRunner.getInProgressBadges(FirebaseRunner.getScout()!)
        .then((value) {
      bools = value[0];
      completes = value[1];
    });
    Acc = Padding(
      padding: EdgeInsets.only(left: 5),
      child: Text('Enter a search word', style: _headerStyle),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!fromButton) {
      Acc = Padding(
        padding: EdgeInsets.only(left: 5),
        child: Text(
          'Enter a search word',
          style: _searchStyle,
        ),
      );
    }
    fromButton = false;
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              CustomHeader('Search', context),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    flex: 5,
                    child: CustomFormField(
                      labelText: 'Badge Name',
                      controller: _tec,
                      hintText: 'Enter a full or partial badge name',
                      obscureText: false,
                      isLast: false,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Material(
                      color: kColorDarkBlue,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      elevation: 5.0,
                      child: TextButton(
                        onPressed: () async {
                          fromButton = true;
                          Widget a = await buildAccordion();
                          setState(() {
                            Acc = a;
                          });
                        },
                        child: Text(
                          'Search',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Acc
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: null,
          onPressed: () async {
            fromButton = true;
            Widget a = await buildAccordion();
            setState(() {
              Acc = a;
            });
          },
          child: Icon(
            Icons.clear,
            color: isLight()
                ? lightColorScheme.onTertiary
                : darkColorScheme.onTertiary,
          ),
          tooltip: 'Collapse Boxes',
        ),
      ),
    );
  }

  Future<Widget> buildAccordion() async {
    List<AccordionSection> lis = [];
    List<MeritBadge> mbs = FirebaseRunner.getSearchResults(_tec.text);

    if (mbs.isEmpty)
      return Padding(
        padding: EdgeInsets.only(left: 5),
        child: Text(
          'No badges found!',
          style: _searchStyle,
        ),
      );

    mbs.sort((a, b) => a.name.compareTo(b.name));

    var li =
        await FirebaseRunner.getInProgressBadges(FirebaseRunner.getScout()!);
    bools = li[0];
    completes = li[1];

    for (MeritBadge mb in mbs) {
      bool isChecked = false;
      bool isComplete = false;
      if (bools[mb.id] != null) isChecked = true;
      if (completes[mb.id] != null) isComplete = true;
      AccordionSection AS = AccordionSection(
          header: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              mb.name,
              style: _headerStyle,
            ),
          ),
          content: Row(
            children: [
              Image.asset(
                'images/badges/${mb.getBadgeIconName()}.png',
                width: 100,
                height: 100,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 1,
                child: Text(
                  mb.name,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).primaryTextTheme.bodyMedium,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              CustomSearchCheckbox(
                checked: isChecked,
                id: mb.id,
                completed: isComplete,
              ),
            ],
          ));

      lis.add(AS);
    }

    Widget acc = Accordion(
      maxOpenSections: 20,
      headerBackgroundColor: AccordionTheme.headerBackgroundColor(),
      headerBackgroundColorOpened: AccordionTheme.headerBackgroundColorOpened(),
      contentBackgroundColor: AccordionTheme.contentBackgroundColor(),
      contentBorderColor: AccordionTheme.contentBorderColor(),
      children: lis,
    );
    return acc;
  }
}
