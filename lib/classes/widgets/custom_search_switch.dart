import 'package:flutter/material.dart';
import 'package:badgr/classes/firebase_runner.dart';
import '../colors_and_themes/themes.dart';
import 'custom_alert.dart';

class CustomSearchSwitch extends StatefulWidget {
  CustomSearchSwitch(
      {required this.id, required this.checked, required this.completed});

  final int id;
  final bool checked;
  final bool completed;

  _searchSwitch createState() =>
      _searchSwitch(id: id, checked: checked, completed: completed);

  int getId() {
    return id;
  }

  bool getChecked() {
    return checked;
  }
}

class _searchSwitch extends State<CustomSearchSwitch> {
  _searchSwitch(
      {required this.id, required this.checked, required this.completed});

  final int id;
  bool checked;
  bool completed;
  String str = "";

  @override
  Widget build(BuildContext context) {
    if (completed) {
      str = 'This badge is \nalready completed!';
      checked = true;
    } else if (checked)
      str = 'This badge is \nin your list';
    else
      str = 'Add this badge \nto your list';
    return Row(
      children: [
        Text(
          str,
          textAlign: TextAlign.right,
          style: Theme.of(context).primaryTextTheme.bodySmall,
        ),
        SizedBox(
          width: 10,
        ),
        Switch(
          value: checked,
          activeColor: CustomSwitchTheme.activeColor,
          activeTrackColor: CustomSwitchTheme.activeTrackColor,
          inactiveTrackColor: CustomSwitchTheme.inactiveTrackColor,
          inactiveThumbColor: CustomSwitchTheme.inactiveColor,
          onChanged: completed
              ? null
              : (val) async {
                  String str = "";
                  try {
                    str = await FirebaseRunner.toggleAddedBadge(id, val);
                    if (str != "Done") throw Exception('Error!');
                  } catch (e) {
                    showDiag(
                        'Error',
                        'An unknown error has occurred. \nPlease try again',
                        context,
                        ['Ok']);
                    return;
                  }
                  setState(() {
                    checked = val;
                  });
                },
        ),
      ],
    );
  }
}
