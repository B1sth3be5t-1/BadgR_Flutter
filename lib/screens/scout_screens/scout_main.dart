import 'package:BadgR/classes/firebase_runner.dart';
import 'package:BadgR/classes/widgets/custom_alert.dart';
import 'package:BadgR/screens/scout_screens/scout_completed.dart';
import 'package:BadgR/screens/scout_screens/scout_home.dart';
import 'package:BadgR/screens/scout_screens/scout_my_badges.dart';
import 'package:BadgR/screens/scout_screens/scout_settings.dart';
import 'package:flutter/material.dart';
import 'package:transitioned_indexed_stack/transitioned_indexed_stack.dart';
import 'package:BadgR/screens/scout_screens/scout_search.dart';
import 'package:BadgR/classes/merit_badge_info.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:BadgR/classes/colors_and_themes/themes.dart';

import '../../classes/person.dart';

class ScoutScreen extends StatefulWidget {
  ScoutScreen();

  static String screenID = 'scoutMainScreen';

  @override
  // ignore: library_private_types_in_public_api
  _scoutMainState createState() => _scoutMainState();
}

class _scoutMainState extends State<ScoutScreen> {
  _scoutMainState();

  Scout? user = FirebaseRunner.getScout();
  bool showSpinner = false;
  bool firstNotif = true;
  late int currentPageIndex;
  final name = FirebaseRunner.getScout()!.name;
  List<Widget> lis = [];

  ScoutMyBadges smb = const ScoutMyBadges();
  ScoutCompleted sc = const ScoutCompleted();
  ScoutSettings ss = const ScoutSettings();
  ScoutHome sh = const ScoutHome();

  @override
  void initState() {
    super.initState();
    AllMeritBadges.setAllBadges(context);
    currentPageIndex = 0;
    getChildren(myBadges: false);
  }

  @override
  Widget build(BuildContext context) {
    AdaptiveTheme.of(context).mode.isLight ? setLight(true) : setLight(false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Welcome $name!',
              style: Theme.of(context)
                  .primaryTextTheme
                  .displayMedium
                  ?.copyWith(fontSize: 25, overflow: TextOverflow.ellipsis),
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
                print('here------');
                return;
              }
              getChildren(myBadges: false);
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
                Icons.search,
                color: NavigationIconTheme.iconColor(context),
              ),
              label: 'Search Badges',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.data_usage,
                color: NavigationIconTheme.iconColor(context),
              ),
              label: 'Saved Badges',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.check_box,
                color: NavigationIconTheme.iconColor(context),
              ),
              icon: Icon(
                Icons.check_box_outlined,
                color: NavigationIconTheme.iconColor(context),
              ),
              label: 'Completed',
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

  void getChildren({required bool myBadges}) {
    lis.clear();

    lis.add(sh);

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
