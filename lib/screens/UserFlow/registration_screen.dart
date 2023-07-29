import 'package:badgr/classes/constants.dart';
import 'package:badgr/classes/firebase_runner.dart';
import 'package:badgr/screens/scout_screens/scout_home.dart';
import 'package:badgr/screens/UserFlow/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:badgr/screens/UserFlow/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:badgr/classes/firebase_runner.dart';
import 'package:badgr/classes/constants.dart';
import 'package:badgr/classes/custom_input.dart';

class RegistrationScreen extends StatefulWidget {
  static const String screenID = 'RegisterScreen';
  const RegistrationScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool validPass = false;
  bool validTroop = false;
  bool validFName = false;
  bool validLName = false;
  bool validAge = false;
  bool showSpinner = false;

  String email = '';
  String pass = '';
  String fname = '';
  String lname = '';
  int age = -1;
  int troop = -1;

  final _formKey = GlobalKey<FormState>();
  bool clickedBut = false;

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
                        if (clickedBut) _formKey.currentState!.validate();
                      },
                      validator: (val) {
                        if (!val!.isValidEmail) return 'Enter valid email';
                        return null;
                      },
                    ),
                    CustomFormField(
                      hintText: 'Password',
                      obscureText: true,
                      onChanged: (val) {
                        pass = val!;
                        if (clickedBut) _formKey.currentState!.validate();
                      },
                      validator: (val) {
                        if (!val!.isValidPassword)
                          return 'Password must contain 8 characters, a letter, and a special character';
                        return null;
                      },
                    ),
                    CustomFormField(
                      hintText: 'First Name',
                      obscureText: false,
                      onChanged: (val) {
                        fname = val!;
                        if (clickedBut) _formKey.currentState!.validate();
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r"[a-zA-Z]+|\s"),
                        )
                      ],
                      validator: (val) {
                        if (!val!.isValidName) return 'Enter valid first name';
                        return null;
                      },
                    ),
                    CustomFormField(
                      hintText: 'Last Name',
                      obscureText: false,
                      onChanged: (val) {
                        lname = val!;
                        if (clickedBut) _formKey.currentState!.validate();
                      },
                      validator: (val) {
                        if (!val!.isValidName) return 'Enter valid last name';
                        return null;
                      },
                    ),
                    CustomFormField(
                      hintText: 'Age',
                      obscureText: false,
                      onChanged: (val) {
                        age = int.parse(val!);
                        if (clickedBut) _formKey.currentState!.validate();
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r"[0-9]"),
                        )
                      ],
                      validator: (val) {
                        if (val == '' ||
                            int.parse(val!) >= 100 ||
                            int.parse(val) <= 5) return 'Enter valid age';
                        return null;
                      },
                    ),
                    CustomFormField(
                      hintText: 'Troop Number',
                      obscureText: false,
                      onChanged: (val) {
                        troop = int.parse(val!);
                        if (clickedBut) _formKey.currentState!.validate();
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r"[0-9]"),
                        )
                      ],
                      validator: (val) {
                        if (val == '' || int.parse(val!) <= 0)
                          return 'Enter valid troop number';
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
                    onPressed: () async {
                      setState(() {
                        clickedBut = true;
                      });
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          showSpinner = true;
                        });
                        String res = '';
                        try {
                          res = await FirebaseRunner.registerUserWithEandP(
                              email, pass, fname, lname, troop, age, context);
                          if (res != 'done') {
                            throw const FormatException('hey');
                          }
                        } on FormatException catch (e) {
                          if (res == 'emailInUse') {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Registration Error'),
                                content:
                                    const Text('This email is already in use'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop('Log');
                                    },
                                    child: const Text('Login',
                                        style:
                                            TextStyle(color: kColorDarkBlue)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop('ok');
                                    },
                                    child: const Text('OK',
                                        style:
                                            TextStyle(color: kColorDarkBlue)),
                                  ),
                                ],
                                backgroundColor: kColorXLightBlue,
                              ),
                            ).then((value) {
                              if (value == null) return;

                              if (value == 'Log') {
                                Navigator.pushNamed(
                                    context, LoginScreen.screenID);
                              }
                            });
                          }
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      }
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
                onPressed: () => {
                  Navigator.pushReplacementNamed(
                      context, WelcomeScreen.screenID),
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
