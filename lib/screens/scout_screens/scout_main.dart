import 'package:badgr/classes/constants.dart';
import 'package:badgr/classes/firebase_runner.dart';
import 'package:badgr/classes/widgets/custom_alert.dart';
import 'package:badgr/screens/scout_screens/scout_completed.dart';
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
  bool firstNotif = true;
  late int currentPageIndex;
  final name = FirebaseRunner.getScout()!.name;
  final bool args;
  List<Widget> lis = [];

  ScoutMyBadges smb = const ScoutMyBadges();
  ScoutCompleted sc = const ScoutCompleted();
  ScoutSettings ss = const ScoutSettings();

  @override
  void initState() {
    super.initState();
    AllMeritBadges.setAllBadges();
    currentPageIndex = args ? 4 : 0;
    getChildren(myBadges: false);
  }

  @override
  Widget build(BuildContext context) {
    AdaptiveTheme.of(context).mode.isLight ? setLight(true) : setLight(false);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Welcome $name!',
            style: Theme.of(context)
                .primaryTextTheme
                .displayLarge
                ?.copyWith(fontSize: 30),
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
          children: lis,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          if (firstNotif &&
              currentPageIndex == 2 &&
              ScoutMyBadgesState.getChangedBool()) {
            showDiag(
                'Reminder',
                'Make sure to click submit on \nthe Saved Badges page \nbefore you exit the app to \nsave your requirement changes!',
                context,
                ['Ok']);
            firstNotif = false;
          }
          setState(() {
            currentPageIndex = index;
            if (index == 2 && ScoutMyBadgesState.isTodo) {
              getChildren(myBadges: true);
              return;
            }
            currentPageIndex = index;
            getChildren(myBadges: false);
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
            icon: Icon(Icons.data_usage),
            label: 'Saved Badges',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.check_box),
            icon: Icon(Icons.check_box_outlined),
            label: 'Completed',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  void getChildren({required bool myBadges}) {
    lis.clear();

    lis.add(
      Container(
        color: Colors.blueGrey,
        alignment: Alignment.center,
        child: const Text('Page 1'),
      ),
    );

    lis.add(ScoutSearch());
    if (myBadges)
      lis.add(ScoutMyBadges());
    else
      lis.add(smb);
    lis.add(sc);
    lis.add(ss);
    setState(() {});
  }
}
