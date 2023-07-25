import 'package:badgr/constants.dart';
import 'package:badgr/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:badgr/screens/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String screenID = 'RegisterScreen';

  const RegistrationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool validEmail = false;
  bool validPass = false;
  bool validTroop = false;
  bool validFName = false;
  bool validLName = false;
  bool validAge = false;

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
            Column(
              children: <Widget>[
                TextField(
                  onChanged: (value) {
                    LoginScreen.isValidEmail(value)
                        ? setState(() {
                            validEmail = true;
                          })
                        : setState(() {
                            validEmail = false;
                          });
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
                    hintText: 'Enter your Password',
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
              ],
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
                  onPressed: !validEmail
                      ? null
                      : () => {
                            //TODO login here
                          },
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text(
                    'Register',
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () =>
                  {Navigator.pushNamed(context, WelcomeScreen.screenID)},
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

  bool isValidPass(String s) {
    return s.contains(RegExp(r'[0-9]')) &&
        s.length >= 8 &&
        s.contains(RegExp(r'[A-Z]'));
  }
}
