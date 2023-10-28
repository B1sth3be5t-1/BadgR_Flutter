import 'package:badgr/screens/user_flow/registration_screen.dart';
import 'package:badgr/screens/user_flow/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:badgr/classes/firebase_runner.dart';
import 'package:badgr/classes/widgets/custom_alert.dart';

import 'package:badgr/classes/widgets/custom_input.dart';
import '../../classes/colors_and_themes/color_schemes.g.dart';
import '../../classes/colors_and_themes/themes.dart';

class LoginScreen extends StatefulWidget {
  static const String screenID = 'LoginScreen';

  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  String email = '';
  String pass = '';

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tex = TextEditingController();

  final _emailFocus = FocusNode();
  final _passFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 8),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomFormField(
                                hintText: 'Enter your email',
                                labelText: 'Email',
                                obscureText: false,
                                onChanged: (val) {
                                  email = val!;
                                },
                                validator: (val) {
                                  if (!val!.isValidEmail)
                                    return 'Enter valid email';
                                  return null;
                                },
                                isLast: false,
                                focusNode: _emailFocus,
                              ),
                              CustomFormField(
                                controller: _tex,
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                obscureText: true,
                                onChanged: (val) {
                                  pass = val!;
                                },
                                validator: (val) {
                                  if (val! == '') return 'Enter a password';
                                  return null;
                                },
                                isLast: true,
                                focusNode: _passFocus,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: MediaQuery.of(context).size.width / 8),
                        child: TextButton(
                          onPressed: () => fun(),
                          child: const Text(
                            'Log In',
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
                            icon: Icon(
                              Icons.arrow_back,
                              color: isLight()
                                  ? lightColorScheme.primary
                                  : darkColorScheme.primary,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          TextButton(
                            onPressed: () {
                              email = '';
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Reset Password'),
                                  content: TextField(
                                    textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      email = value;
                                    },
                                    decoration: const InputDecoration(
                                      hintText: 'Enter your email',
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop('Cancel');
                                      },
                                      child: const Text(
                                        'Cancel',
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          showSpinner = true;
                                        });
                                        Navigator.of(context).pop('Reset');
                                      },
                                      child: const Text(
                                        'Reset',
                                      ),
                                    ),
                                  ],
                                  backgroundColor:
                                      AlertDiagTheme.backgroundColor(),
                                ),
                              ).then((value) async {
                                if (value == null) return;

                                if (value == 'Reset') {
                                  String res = '';
                                  try {
                                    res = await FirebaseRunner.resetPass(email);
                                    if (res != 'done')
                                      throw FormatException('HEY!');
                                  } on FormatException {
                                    if (res == 'network') {
                                      showDiag(
                                          'Password Reset Error',
                                          'A network error has occurred',
                                          context,
                                          ['Ok']);
                                    } else if (res == 'enterEmail') {
                                      showDiag(
                                          'Password Reset Error',
                                          'Please enter an email address',
                                          context,
                                          ['Ok']);
                                    } else if (res == 'user-not-found') {
                                      showDiag(
                                          'Password Reset Error',
                                          'Email does not exist',
                                          context,
                                          ['Ok']);
                                    } else if (res != 'done') {
                                      showDiag(
                                          'Password Reset Error',
                                          'An unknown error occurred',
                                          context,
                                          ['Ok']);
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
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          IconButton(
                            onPressed: null,
                            icon: Text(''),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom + 100,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void fun() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        showSpinner = true;
      });
      String res = '';
      try {
        res = await FirebaseRunner.loginUserWithEandP(
            email.toLowerCase(), pass, context);
        if (res != 'done') throw FormatException('heyyyyy!');
      } on FormatException {
        if (res == 'wrongEmailPass') {
          showDiag('Login Error', 'The username or password is incorrect',
              context, ['Register', 'Ok']).then((value) {
            if (value == null) return;

            if (value == 'Register') {
              Navigator.pushNamed(context, RegistrationScreen.screenID);
            }
          });
        } else if (res == 'tooMany') {
          showDiag(
              'Login Error',
              'You have entered too many incorrect password attempts. \nPlease try again later',
              context,
              ['Ok']);
        } else if (res == 'network') {
          showDiag(
              'Login Error', 'A network error has occurred', context, ['Ok']);
        } else if (res != 'done') {
          showDiag(
              'Login Error', 'An unknown error has occurred', context, ['Ok']);
        }
      }
      setState(() {
        showSpinner = false;
        pass = '';
      });
    }
    _tex.clear();
    pass = '';
  }
}
