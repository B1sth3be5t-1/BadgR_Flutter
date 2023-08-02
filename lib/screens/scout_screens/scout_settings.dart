import 'package:badgr/classes/constants.dart';
import 'package:flutter/material.dart';
import 'package:badgr/classes/firebase_runner.dart';

class ScoutSettings extends StatefulWidget {
  const ScoutSettings({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ScoutSettingsState createState() => _ScoutSettingsState();
}

class _ScoutSettingsState extends State<ScoutSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: ListView(
            children: [settingsField(func: () {}, text: 'Account')],
          ),
        ),
      ),
    );
  }
}

class settingsField extends StatelessWidget {
  settingsField({required this.func, required this.text});

  final Function() func;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kColorLightPink,
      child: TextButton(
        onPressed: func,
        child: Text(
          text,
          style: TextStyle(color: kColorXDarkBlue),
        ),
      ),
    );
  }
}
