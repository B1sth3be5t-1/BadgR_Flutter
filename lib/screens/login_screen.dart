import 'package:badgr/constants.dart';
import 'package:badgr/screens/registration_screen.dart';
import 'package:badgr/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginScreen extends StatefulWidget {
  static const String screenID = 'LoginScreen';

  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();

  static bool isValidEmail(String s) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(s);
  }
}

class _LoginScreenState extends State<LoginScreen> {
  bool buttonActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 200.0,
              child: Hero(
                tag: 'head',
                child: Image.asset('images/BadgRHead.png'),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              onChanged: (s) {
                if (LoginScreen.isValidEmail(s)) {
                  setState(() {
                    buttonActive = true;
                  });
                } else {
                  setState(() {
                    buttonActive = false;
                  });
                }
              },
              decoration: const InputDecoration(
                hintText: 'Enter your email',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: kBorder,
                enabledBorder: kBorderEnabled,
                focusedBorder: kBorderFocused,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {},
              decoration: const InputDecoration(
                  hintText: 'Enter your password.',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: kBorder,
                  enabledBorder: kBorderEnabled,
                  focusedBorder: kBorderFocused),
            ),
            const SizedBox(
              height: 24.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: kColorDarkBlue,
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: !buttonActive
                      ? null
                      : () => {
                            //TODO login here
                          },
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text(
                    'Log In',
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () =>
                  {Navigator.popUntil(context, (route) => route.isFirst)},
              icon: const Icon(
                Icons.arrow_back,
              ),
              color: kColorDarkBlue,
            ),
          ],
        ),
      ),
    );
  }
}
