import 'package:flutter/material.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget(
      {required this.BGcolor, required this.textColor, required this.map});

  final Color BGcolor;
  final Color textColor;
  final Map<String, Function()> map;

  @override
  // ignore: library_private_types_in_public_api
  _SettingsWidgetState createState() =>
      _SettingsWidgetState(BGcolor: BGcolor, textColor: textColor, map: map);
}

class _SettingsWidgetState extends State<SettingsWidget> {
  _SettingsWidgetState(
      {required this.BGcolor, required this.textColor, required this.map});

  final Color BGcolor;
  final Color textColor;
  final Map<String, Function()> map;
  late final List<settingsField> list;

  @override
  void initState() {
    super.initState();
    list = getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
          child: ListView(
            children: list,
          ),
        ),
      ),
    );
  }

  List<settingsField> getList() {
    List<settingsField> lis = [];

    for (var entry in map.entries) {
      lis.add(settingsField(
        func: entry.value,
        text: entry.key,
        BGcolor: BGcolor,
        textColor: textColor,
      ));
    }

    return lis;
  }
}

class settingsField extends StatelessWidget {
  settingsField(
      {required this.func,
      required this.text,
      required this.BGcolor,
      required this.textColor});

  final Function() func;
  final String text;
  final Color BGcolor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Material(
        color: BGcolor,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: TextButton(
            onPressed: func,
            child: Text(
              text,
              style: TextStyle(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
