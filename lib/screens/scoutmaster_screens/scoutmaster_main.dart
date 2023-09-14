import 'package:badgr/classes/firebase_runner.dart';
import 'package:badgr/classes/widgets/custom_alert.dart';
import 'package:badgr/screens/scoutmaster_screens/scoutmaster_settings.dart';
import 'package:flutter/material.dart';
import 'package:transitioned_indexed_stack/transitioned_indexed_stack.dart';
import 'package:badgr/classes/merit_badge_info.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:badgr/classes/themes.dart';

import '../../classes/person.dart';

class ScoutmasterScreen extends StatefulWidget {
  static String screenID = 'scoutmasterMainScreen';

  @override
  // ignore: library_private_types_in_public_api
  _scoutmasterMainState createState() => _scoutmasterMainState();
}

class _scoutmasterMainState extends State<ScoutmasterScreen> {
  Scoutmaster? user = FirebaseRunner.getScoutmaster();
  late int currentPageIndex;
  final name = FirebaseRunner.getScoutmaster()!.name;
  List<Widget> lis = [];

  @override
  void initState() {
    super.initState();
    AllMeritBadges.setAllBadges();
    currentPageIndex = 0;
    lis.add(
      ColoredBox(
        color: Colors.red,
        child: Text('Page1'),
      ),
    );
    lis.add(
      ColoredBox(
        color: Colors.blue,
        child: Text('Page2'),
      ),
    );
    lis.add(
      ColoredBox(
        color: Colors.lightGreen,
        child: Text('Page3'),
      ),
    );
    lis.add(const ScoutmasterSettings());
  }

  @override
  Widget build(BuildContext context) {
    AdaptiveTheme.of(context).mode.isLight ? setLight(true) : setLight(false);
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Welcome $name!',
            style: Theme.of(context)
                .primaryTextTheme
                .displayLarge
                ?.copyWith(fontSize: 30),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: IconButton(
            onPressed: () async {
              String logout = '';
              try {
                logout = FirebaseRunner.logoutUser();
                if (logout != 'Done')
                  throw Exception('Error!');
                else {
                  Navigator.pop(context);
                }
              } catch (e) {
                showDiag(
                    'Error',
                    'An error occurred while logging out. \nPlease try again',
                    context,
                    ['Ok']);
              }
            },
            icon: Icon(Icons.arrow_back),
            tooltip: 'Logout',
          ),
        ),
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
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              color: NavigationIconTheme.iconColor,
            ),
            selectedIcon: Icon(
              Icons.home_rounded,
              color: NavigationIconTheme.iconColor,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.notifications_active_outlined,
              color: NavigationIconTheme.iconColor,
            ),
            selectedIcon: Icon(
              Icons.notifications_active,
              color: NavigationIconTheme.iconColor,
            ),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.data_usage,
              color: NavigationIconTheme.iconColor,
            ),
            label: 'Troop Progress',
          ),
          /*NavigationDestination(
            selectedIcon: Icon(
              Icons.check_box,
              color: NavigationIconTheme.iconColor,
            ),
            icon: Icon(
              Icons.check_box_outlined,
              color: NavigationIconTheme.iconColor,
            ),
            label: 'Completed',
          ), */
          NavigationDestination(
            selectedIcon: Icon(
              Icons.settings,
              color: NavigationIconTheme.iconColor,
            ),
            icon: Icon(
              Icons.settings_outlined,
              color: NavigationIconTheme.iconColor,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
