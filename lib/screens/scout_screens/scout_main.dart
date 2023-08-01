import 'package:badgr/classes/constants.dart';
import 'package:badgr/classes/firebase_runner.dart';
import 'package:badgr/screens/scout_screens/scout_my_badges.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:transitioned_indexed_stack/transitioned_indexed_stack.dart';
import '../../classes/person.dart';

class ScoutScreen extends StatefulWidget {
  const ScoutScreen({super.key});
  static String screenID = 'scoutMainScreen';

  @override
  // ignore: library_private_types_in_public_api
  _scoutMainState createState() => _scoutMainState();
}

class _scoutMainState extends State<ScoutScreen> {
  late Person user;
  bool showSpinner = false;
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    user = FirebaseRunner.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: SizedBox.expand(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
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
              Container(
                color: Colors.green,
                alignment: Alignment.center,
                child: const Text('Page 2'),
              ),
              const ScoutMyBadges(),
              Container(
                color: Colors.purple,
                alignment: Alignment.center,
                child: const Text('Page 4'),
              ),
            ],
          ),
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
