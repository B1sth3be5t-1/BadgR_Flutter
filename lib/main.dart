import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:badgr/classes/constants.dart';
import 'package:badgr/screens/scout_screens/scout_main.dart';
import 'package:flutter/material.dart';
import 'package:badgr/screens/UserFlow/welcome_screen.dart';
import 'package:badgr/screens/UserFlow/login_screen.dart';
import 'package:badgr/screens/UserFlow/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'classes/firebase_options.dart';
import 'classes/constants.dart';
import 'classes/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(BadgR(savedThemeMode: savedThemeMode));
}

class BadgR extends StatelessWidget {
  BadgR({super.key, this.savedThemeMode});

  final savedThemeMode;

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: kThemeLight,
      dark: kThemeDark,
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Adaptive Theme Demo',
        theme: theme,
        darkTheme: darkTheme,
        initialRoute: WelcomeScreen.screenID,
        routes: {
          WelcomeScreen.screenID: (context) => const WelcomeScreen(),
          LoginScreen.screenID: (context) => const LoginScreen(),
          RegistrationScreen.screenID: (context) => const RegistrationScreen(),
          ScoutScreen.screenID: (context) => const ScoutScreen()
        },
      ),
    );
  }
}
