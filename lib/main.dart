import 'package:flutter/material.dart';
import 'package:badgr/screens/welcome_screen.dart';
import 'package:badgr/screens/login_screen.dart';
import 'package:badgr/screens/registration_screen.dart';

void main() => runApp(const BadgR());

class BadgR extends StatelessWidget {
  const BadgR({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black54),
        ),
      ),
      color: Colors.white,
      home: const WelcomeScreen(),
      routes: {
        WelcomeScreen.screenID: (context) => const WelcomeScreen(),
        LoginScreen.screenID: (context) => const LoginScreen(),
        RegistrationScreen.screenID: (context) => const RegistrationScreen(),
      },
    );
  }
}
