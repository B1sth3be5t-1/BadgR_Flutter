import 'package:badgr/classes/constants.dart';
import 'package:badgr/screens/UserFlow/registration_screen.dart';
import 'package:badgr/screens/UserFlow/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:badgr/classes/firebase_runner.dart';
import 'package:badgr/classes/Widgets/custom_input.dart';
import 'package:badgr/classes/widgets/custom_alert.dart';

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

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tex = TextEditingController();

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
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomFormField(
                      hintText: 'Email',
                      obscureText: false,
                      onChanged: (val) {
                        email = val!;
                        if (email.isValidEmail)
                          setState(() {
                            buttonActive = true;
                          });
                        else
                          setState(() {
                            buttonActive = false;
                          });
                      },
                      validator: (val) {
                        if (!val!.isValidEmail) return 'Enter valid email';
                        return null;
                      },
                    ),
                    CustomFormField(
                      controller: _tex,
                      hintText: 'Password',
                      obscureText: true,
                      onChanged: (val) {
                        pass = val!;
                      },
                      validator: (val) {
                        if (val! == '') return 'Enter a password';
                        return null;
                      },
                    ),
                  ],
                ),
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
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                showSpinner = true;
                              });
                              String res = '';
                              try {
                                res = await FirebaseRunner.loginUserWithEandP(
                                    email.toLowerCase(), pass, context);
                                if (res != 'done')
                                  throw FormatException('heyyyyy!');
                              } on FormatException {
                                if (res == 'wrongEmailPass') {
                                  showDiag(
                                          'Login Error',
                                          'The username or password is incorrect',
                                          context,
                                          ['Register', 'Ok'],
                                          kColorXLightBlue,
                                          kColorDarkBlue)
                                      .then((value) {
                                    if (value == null) return;

                                    if (value == 'Register') {
                                      Navigator.pushNamed(
                                          context, RegistrationScreen.screenID);
                                    }
                                  });
                                } else if (res == 'tooMany') {
                                  showDiag(
                                      'Login Error',
                                      'You have entered too many incorrect password attempts. \nPlease try again later',
                                      context,
                                      ['Ok'],
                                      kColorXLightBlue,
                                      kColorDarkBlue);
                                } else if (res == 'network') {
                                  showDiag(
                                      'Login Error',
                                      'A network error has occurred',
                                      context,
                                      ['Ok'],
                                      kColorXLightBlue,
                                      kColorDarkBlue);
                                } else if (res != 'done') {
                                  showDiag(
                                      'Login Error',
                                      'An unknown error has occurred',
                                      context,
                                      ['Ok'],
                                      kColorXLightBlue,
                                      kColorDarkBlue);
                                }
                              }
                              setState(() {
                                showSpinner = false;
                                pass = '';
                              });
                            }
                            _tex.clear();
                            pass = '';
                          },
                    minWidth: 200.0,
                    height: 42.0,
                    child: const Text(
                      'Log In',
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  TextButton(
                    onPressed: () {
                      email = '';
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Reset Password'),
                          content: TextField(
                            cursorColor: kColorBlue,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              email = value;
                            },
                            decoration: const InputDecoration(
                                hintText: 'Enter your email',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                border: null,
                                enabledBorder: kBorderEnabled,
                                focusedBorder: kBorderFocused),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop('Cancel');
                              },
                              child: const Text('Cancel',
                                  style: TextStyle(color: kColorDarkBlue)),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  showSpinner = true;
                                });
                                Navigator.of(context).pop('Reset');
                              },
                              child: const Text('Reset',
                                  style: TextStyle(color: kColorDarkBlue)),
                            ),
                          ],
                          backgroundColor: kColorXLightBlue,
                        ),
                      ).then((value) async {
                        if (value == null) return;

                        if (value == 'Reset') {
                          String res = '';
                          try {
                            res = await FirebaseRunner.resetPass(email);
                            if (res != 'done') throw FormatException('HEY!');
                          } on FormatException {
                            if (res == 'network') {
                              showDiag(
                                  'Password Reset Error',
                                  'A network error has occurred',
                                  context,
                                  ['Ok'],
                                  kColorXLightBlue,
                                  kColorDarkBlue);
                            } else if (res == 'enterEmail') {
                              showDiag(
                                  'Password Reset Error',
                                  'Please enter an email address',
                                  context,
                                  ['Ok'],
                                  kColorXLightBlue,
                                  kColorDarkBlue);
                            } else if (res == 'user-not-found') {
                              showDiag(
                                  'Password Reset Error',
                                  'Email does not exist',
                                  context,
                                  ['Ok'],
                                  kColorXLightBlue,
                                  kColorDarkBlue);
                            } else if (res != 'done') {
                              showDiag(
                                  'Password Reset Error',
                                  'An unknown error occurred',
                                  context,
                                  ['Ok'],
                                  kColorXLightBlue,
                                  kColorDarkBlue);
                            }
                          }
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      });
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: kColorDarkBlue),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
