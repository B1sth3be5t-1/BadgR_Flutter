import 'package:badgr/classes/firebase_runner.dart';
import 'package:badgr/classes/widgets/custom_alert.dart';
import 'package:badgr/screens/scoutmaster_screens/scoutmaster_home.dart';
import 'package:badgr/screens/scoutmaster_screens/scoutmaster_my_troop.dart';
import 'package:badgr/screens/scoutmaster_screens/scoutmaster_notifications.dart';
import 'package:badgr/screens/scoutmaster_screens/scoutmaster_settings.dart';
import 'package:flutter/material.dart';
import 'package:transitioned_indexed_stack/transitioned_indexed_stack.dart';
import 'package:badgr/classes/merit_badge_info.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:badgr/classes/colors_and_themes/themes.dart';

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
  final Scoutmaster sm = FirebaseRunner.getScoutmaster()!;
  List<Widget> lis = [];

  @override
  void initState() {
    super.initState();
    AllMeritBadges.setAllBadges(context);
    currentPageIndex = 0;
    lis.add(ScoutmasterHome());
    lis.add(ScoutmasterNotifications());
    lis.add(ScoutmasterMyTroop(sm: sm));
    lis.add(const ScoutmasterSettings());
  }

  @override
  Widget build(BuildContext context) {
    AdaptiveTheme.of(context).mode.isLight ? setLight(true) : setLight(false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.all(7),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Welcome $name!',
                style:
                    Theme.of(context).primaryTextTheme.displayMedium?.copyWith(
                          fontSize: 25,
                          overflow: TextOverflow.ellipsis,
                        ),
              ),
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 5, top: 5),
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
                color: NavigationIconTheme.iconColor(context),
              ),
              selectedIcon: Icon(
                Icons.home_rounded,
                color: NavigationIconTheme.iconColor(context),
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.notifications_active_outlined,
                color: NavigationIconTheme.iconColor(context),
              ),
              selectedIcon: Icon(
                Icons.notifications_active,
                color: NavigationIconTheme.iconColor(context),
              ),
              label: 'Notification',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.data_usage,
                color: NavigationIconTheme.iconColor(context),
              ),
              label: 'Troop Progress',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.settings,
                color: NavigationIconTheme.iconColor(context),
              ),
              icon: Icon(
                Icons.settings_outlined,
                color: NavigationIconTheme.iconColor(context),
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
