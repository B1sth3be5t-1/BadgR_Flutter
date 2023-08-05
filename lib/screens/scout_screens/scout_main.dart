import 'package:badgr/classes/constants.dart';
import 'package:badgr/classes/firebase_runner.dart';
import 'package:badgr/screens/scout_screens/scout_my_badges.dart';
import 'package:badgr/screens/scout_screens/scout_settings.dart';
import 'package:flutter/material.dart';
import 'package:transitioned_indexed_stack/transitioned_indexed_stack.dart';
import 'package:badgr/screens/scout_screens/scout_search.dart';

import '../../classes/person.dart';

class ScoutScreen extends StatefulWidget {
  const ScoutScreen({super.key});
  static String screenID = 'scoutMainScreen';

  @override
  // ignore: library_private_types_in_public_api
  _scoutMainState createState() => _scoutMainState();
}

class _scoutMainState extends State<ScoutScreen> {
  Person user = FirebaseRunner.getUser();
  bool showSpinner = false;
  int currentPageIndex = 0;
  final name = FirebaseRunner.getUser().name;

  @override
  Widget build(BuildContext context) {
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
      backgroundColor: Colors.white54,
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
        indicatorColor: kColorDarkPink,
      ),
    );
  }
}
