import 'package:badgr/classes/constants.dart';
import 'package:flutter/material.dart';
import 'package:badgr/classes/widgets/settings.dart';

class ScoutSettings extends StatefulWidget {
  const ScoutSettings({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ScoutSettingsState createState() => _ScoutSettingsState();
}

class _ScoutSettingsState extends State<ScoutSettings> {
  static Map<String, Function()> map = Map();

  @override
  void initState() {
    super.initState();
    map['Account'] = () {};
    map['Personalization'] = () {};
  }

  @override
  Widget build(BuildContext context) {
    return SettingsWidget(
      BGcolor: kColorLightPink,
      textColor: kColorXDarkBlue,
      map: map,
    );
  }
}
