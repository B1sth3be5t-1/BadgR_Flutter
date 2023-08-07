import 'package:badgr/classes/constants.dart';
import 'package:badgr/screens/scout_screens/scout_main.dart';
import 'package:flutter/material.dart';
import 'package:badgr/screens/UserFlow/welcome_screen.dart';
import 'package:badgr/screens/UserFlow/login_screen.dart';
import 'package:badgr/screens/UserFlow/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const BadgR());
}

class BadgR extends StatelessWidget {
  const BadgR({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
        ),
        primaryColor: kColorBlue,
        primaryColorLight: kColorLightBlue,
        primaryColorDark: kColorDarkBlue,
      ),
      color: Colors.white,
      home: const WelcomeScreen(),
      routes: {
        WelcomeScreen.screenID: (context) => const WelcomeScreen(),
        LoginScreen.screenID: (context) => const LoginScreen(),
        RegistrationScreen.screenID: (context) => const RegistrationScreen(),
        ScoutScreen.screenID: (context) => const ScoutScreen()
      },
    );
  }
}
