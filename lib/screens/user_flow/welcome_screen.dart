import 'package:badgr/screens/user_flow/login_screen.dart';
import 'package:badgr/screens/user_flow/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:badgr/classes/colors_and_themes/themes.dart';

class WelcomeScreen extends StatefulWidget {
  static const String screenID = 'badgr_screen';

  const WelcomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 60.0,
                      child: Hero(
                        tag: 'head',
                        child: Image.asset('images/BadgRHead.png'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50.0),
                      child: Text(
                        'BadgR',
                        style: AdaptiveTheme.of(context)
                            .theme
                            .primaryTextTheme
                            .displayLarge,
                      ),
                    ),
                    SizedBox(
                      width: 60.0,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: MediaQuery.of(context).size.width / 8),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.screenID);
                  },
                  child: const Text(
                    'Log In',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: MediaQuery.of(context).size.width / 8),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.screenID);
                  },
                  child: const Text(
                    'Register',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: MediaQuery.of(context).size.width / 8),
                child: TextButton(
                  onPressed: () => switchTheme(context),
                  child: Center(child: Text('Switch app appearance')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
