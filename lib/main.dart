import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:badgr/screens/scout_screens/scout_main.dart';
import 'package:flutter/material.dart';
import 'package:badgr/screens/UserFlow/welcome_screen.dart';
import 'package:badgr/screens/UserFlow/login_screen.dart';
import 'package:badgr/screens/UserFlow/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'classes/firebase_options.dart';
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
          final args = settings.arguments;
          if (settings.name == ScoutScreen.screenID) {
            bool arg = false;
            if (args != null) arg = args as bool;

            // Then, extract the required data from
            // the arguments and pass the data to the
            // correct screen.
            return MaterialPageRoute(
              builder: (context) => ScoutScreen(
                isSettings: arg,
              ),
            );
          } else if (settings.name == RegistrationScreen.screenID)
            return MaterialPageRoute(
                builder: (context) => RegistrationScreen());
          else if (settings.name == WelcomeScreen.screenID)
            return MaterialPageRoute(builder: (context) => WelcomeScreen());
          else if (settings.name == LoginScreen.screenID)
            return MaterialPageRoute(builder: (context) => LoginScreen());
          assert(false, 'Need to implement ${settings.name}');
          return MaterialPageRoute(builder: (context) => WelcomeScreen());
        },
      ),
    );
  }
}
