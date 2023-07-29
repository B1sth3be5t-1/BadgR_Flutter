import 'package:badgr/classes/constants.dart';
import 'package:badgr/classes/firebaserunner.dart';
import 'package:badgr/screens/scout_screens/scout_home.dart';
import 'package:badgr/screens/UserFlow/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:badgr/screens/UserFlow/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:badgr/classes/firebaserunner.dart';
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
  int age = 0;
  int troop = 0;

  final _formKey = GlobalKey<FormState>();
  int currentStep = 0;

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
              Column(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const CustomInput(
                          hint: "Email",
                          inputBorder: OutlineInputBorder(),
                        ),
                        const CustomInput(
                          hint: "Password",
                          inputBorder: OutlineInputBorder(),
                        ),
                        const CustomInput(
                          hint: "First Name",
                          inputBorder: OutlineInputBorder(),
                        ),
                        const CustomInput(
                          hint: "Last Name",
                          inputBorder: OutlineInputBorder(),
                        ),
                        const CustomInput(
                          hint: "Age",
                          inputBorder: OutlineInputBorder(),
                        ),
                        const CustomInput(
                          hint: "Troop Number",
                          inputBorder: OutlineInputBorder(),
                        ),
                        TextFormField(
                          cursorColor: kColorBlue,
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            hintText: 'Enter your email',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            border: kBorder,
                            enabledBorder: kBorderEnabled,
                            focusedBorder: kBorderFocused,
                          ),
                          validator: (val) {
                            if (val == null || !LoginScreen.isValidEmail(val)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          onChanged: (val) => {email = val},
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextFormField(
                          cursorColor: kColorBlue,
                          obscureText: true,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            pass = value;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Enter your Password',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            border: kBorder,
                            enabledBorder: kBorderEnabled,
                            focusedBorder: kBorderFocused,
                          ),
                          validator: (val) {
                            if (val == null || isValidPass(val)) {
                              return 'Password must be more than 8 characters and contain a Capital letter and a number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Material(
                            color: kColorDarkBlue,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30.0)),
                            elevation: 5.0,
                            child: MaterialButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  String res = '';
                                  try {
                                    res = await FirebaseRunner
                                        .registerUserWithEandP(email, pass,
                                            fname, lname, troop, age, context);
                                    if (res != 'done') {
                                      throw const FormatException('hey');
                                    }
                                  } on FormatException catch (e) {
                                    if (res == 'emailInUse') {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title:
                                              const Text('Registration Error'),
                                          content: const Text(
                                              'This email is already in use'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, 'OK'),
                                              child: const Text('OK',
                                                  style: TextStyle(
                                                      color: kColorDarkBlue)),
                                            ),
                                          ],
                                          backgroundColor: kColorXLightBlue,
                                        ),
                                      );
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
                      ],
                    ),
                  ),
                ],
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

  bool isValidPass(String s) {
    return s.contains(RegExp(r'[0-9]')) &&
        s.length >= 8 &&
        s.contains(RegExp(r'[A-Z]'));
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text("Account Info"),
        content: const Column(
          children: [
            CustomInput(
              hint: "Email",
              inputBorder: OutlineInputBorder(),
            ),
            CustomInput(
              hint: "Password",
              inputBorder: OutlineInputBorder(),
            ),
          ],
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text("Person Info"),
        content: const Column(
          children: [
            CustomInput(
              hint: "First Name",
              inputBorder: OutlineInputBorder(),
            ),
            CustomInput(
              hint: "Last Name",
              inputBorder: OutlineInputBorder(),
            ),
            CustomInput(
              hint: "Age",
              inputBorder: OutlineInputBorder(),
            ),
          ],
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text("Troop Info"),
        content: const Column(
          children: [
            CustomInput(
              hint: "Troop Number",
              inputBorder: OutlineInputBorder(),
            ),
          ],
        ),
      ),
    ];
  }
}
