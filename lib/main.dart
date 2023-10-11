import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:BadgR/screens/scout_screens/scout_main.dart';
import 'package:BadgR/screens/scoutmaster_screens/scoutmaster_main.dart';
import 'package:flutter/material.dart';
import 'package:BadgR/screens/user_flow/welcome_screen.dart';
import 'package:BadgR/screens/user_flow/login_screen.dart';
import 'package:BadgR/screens/user_flow/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'classes/firebase_options.dart';
import 'classes/colors_and_themes/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BadgR(savedThemeMode: savedThemeMode));
}

class BadgR extends StatelessWidget {
  BadgR({super.key, this.savedThemeMode});

  final savedThemeMode;

  @override
  Widget build(BuildContext context) {
    if (savedThemeMode == AdaptiveThemeMode.dark)
      setLight(false);
    else
      setLight(true);

    return AdaptiveTheme(
      light: kThemeLight,
      dark: kThemeDark,
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'BadgR',
        theme: theme,
        darkTheme: darkTheme,
        initialRoute: WelcomeScreen.screenID,
        /*routes: {
          WelcomeScreen.screenID: (context) => const WelcomeScreen(),
          LoginScreen.screenID: (context) => const LoginScreen(),
          RegistrationScreen.screenID: (context) => const RegistrationScreen(),
          ScoutScreen.screenID: (context) =>
              const ScoutScreen(isSettings: false),
        }, */
        onGenerateRoute: (settings) {
          // If you push the PassArguments route
          if (settings.name == ScoutScreen.screenID) {
            return MaterialPageRoute(builder: (context) => ScoutScreen());
          } else if (settings.name == RegistrationScreen.screenID)
            return MaterialPageRoute(
                builder: (context) => RegistrationScreen());
          else if (settings.name == WelcomeScreen.screenID)
            return MaterialPageRoute(builder: (context) => WelcomeScreen());
          else if (settings.name == LoginScreen.screenID)
            return MaterialPageRoute(builder: (context) => LoginScreen());
          else if (settings.name == ScoutmasterScreen.screenID)
            return MaterialPageRoute(builder: (context) => ScoutmasterScreen());
          else if (settings.name == LoginScreen.screenID)
            assert(false, 'Need to implement ${settings.name}');
          return MaterialPageRoute(builder: (context) => WelcomeScreen());
        },
      ),
    );
  }
}
