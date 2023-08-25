import 'package:badgr/classes/constants.dart';
import 'package:badgr/classes/firebase_runner.dart';
import 'package:badgr/screens/scout_screens/scout_my_badges.dart';
import 'package:badgr/screens/scout_screens/scout_settings.dart';
import 'package:flutter/material.dart';
import 'package:transitioned_indexed_stack/transitioned_indexed_stack.dart';
import 'package:badgr/screens/scout_screens/scout_search.dart';
import 'package:badgr/classes/merit_badge_info.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:badgr/classes/themes.dart';

import '../../classes/person.dart';

class ScoutScreen extends StatefulWidget {
  ScoutScreen({required this.isSettings});

  final bool isSettings;
  static String screenID = 'scoutMainScreen';

  @override
  // ignore: library_private_types_in_public_api
  _scoutMainState createState() => _scoutMainState(args: isSettings);
}

class _scoutMainState extends State<ScoutScreen> {
  _scoutMainState({required this.args});

  Scout? user = FirebaseRunner.getScout();
  bool showSpinner = false;
  late int currentPageIndex;
  final name = FirebaseRunner.getScout()!.name;
  final bool args;

  @override
  void initState() {
    super.initState();
    AllMeritBadges().setAllBadges();
    currentPageIndex = args ? 3 : 0;
  }

  @override
  Widget build(BuildContext context) {
    AdaptiveTheme.of(context).mode.isLight ? setLight(true) : setLight(false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorXLightPink,
        leading: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Welcome $name!',
            style: TextStyle(color: kColorDarkBlue, fontSize: 30),
          ),
        ),
        leadingWidth: 400,
      ),
      body: SizedBox.expand(
        child: FadeIndexedStack(
          beginOpacity: 0.5,
          endOpacity: 1.0,
          curve: Curves.easeIn,
          duration: const Duration(milliseconds: 400),
          index: currentPageIndex,
          children: <Widget>[
            Container(
              color: Colors.red,
              alignment: Alignment.center,
              child: const Text('Page 1'),
            ),
            const ScoutSearch(),
            const ScoutMyBadges(),
            const ScoutSettings(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Search Badges',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.check_box),
            icon: Icon(Icons.check_box_outlined),
            label: 'Saved Badges',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
        indicatorColor: kColorBlue,
        backgroundColor: kColorLightPink,
      ),
    );
  }
}
