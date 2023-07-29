import 'package:badgr/classes/constants.dart';
import 'package:badgr/screens/UserFlow/registration_screen.dart';
import 'package:badgr/screens/scout_screens/scout_home.dart';
import 'package:badgr/screens/UserFlow/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:badgr/classes/firebase_runner.dart';
import 'package:badgr/classes/custom_input.dart';

class LoginScreen extends StatefulWidget {
  static const String screenID = 'LoginScreen';

  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  bool buttonActive = false;
  String email = '';
  String pass = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
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
                cursorColor: kColorBlue,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (s) {
                  if (s.isValidEmail) {
                    setState(() {
                      buttonActive = true;
                    });
                  } else {
                    setState(() {
                      buttonActive = false;
                    });
                  }
                  email = s;
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
                cursorColor: kColorBlue,
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  pass = value;
                },
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
                        : () async {
                            setState(() {
                              showSpinner = true;
                            });
                            String res = '';
                            try {
                              res = await FirebaseRunner.loginUserWithEandP(
                                  email, pass, context);
                              if (res != 'done') {
                                throw const FormatException('hey2.0');
                              }
                            } on FormatException catch (e) {
                              if (res == 'wrongEmailPass') {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Login Error'),
                                    content: const Text(
                                        'The username or password is incorrect'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop('Reg');
                                        },
                                        child: const Text('Register',
                                            style: TextStyle(
                                                color: kColorDarkBlue)),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop('ok');
                                        },
                                        child: const Text('OK',
                                            style: TextStyle(
                                                color: kColorDarkBlue)),
                                      ),
                                    ],
                                    backgroundColor: kColorXLightBlue,
                                  ),
                                ).then((value) {
                                  if (value == null) return;

                                  if (value == 'Reg') {
                                    Navigator.pushNamed(
                                        context, RegistrationScreen.screenID);
                                  }
                                });
                              } else if (res == 'noEmail') {
                              } else if (res == 'tooMany') {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Login Error'),
                                    content: const Text(
                                        'You have entered too many incorrect password attempts. \nPlease try again later'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop('Ok');
                                        },
                                        child: const Text('Ok',
                                            style: TextStyle(
                                                color: kColorDarkBlue)),
                                      ),
                                    ],
                                    backgroundColor: kColorXLightBlue,
                                  ),
                                );
                              } else {}
                              //todo login error
                            }
                            setState(() {
                              showSpinner = false;
                            });
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
                onPressed: () => {
                  Navigator.pushReplacementNamed(
                      context, WelcomeScreen.screenID)
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
                color: kColorDarkBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
