import 'package:badgr/classes/constants.dart';
import 'package:badgr/classes/firebase_runner.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../classes/person.dart';

class ScoutScreen extends StatefulWidget {
  const ScoutScreen({super.key});
  static String screenID = 'scoutHomeScreen';

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ScoutScreen> {
  late Person user;
  bool showSpinner = false;
  int currentPageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    user = FirebaseRunner.getUser();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      body: SizedBox.expand(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => currentPageIndex = index);
            },
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
              Container(
                color: Colors.blue,
                alignment: Alignment.center,
                child: const Text('Page 3'),
              ),
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
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 350), curve: Curves.easeOut);
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
