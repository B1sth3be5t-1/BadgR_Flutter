import 'package:flutter/material.dart';
import 'package:badgr/classes/firebase_runner.dart';
import '../constants.dart';
import 'custom_alert.dart';

class CustomCheckbox extends StatefulWidget {
  CustomCheckbox(
      {required this.id, required this.checked, required this.completed});

  final int id;
  final bool checked;
  final bool completed;

  _checkbox createState() =>
      _checkbox(id: id, checked: checked, completed: completed);

  int getId() {
    return id;
  }

  bool getChecked() {
    return checked;
  }
}

class _checkbox extends State<CustomCheckbox> {
  _checkbox({required this.id, required this.checked, required this.completed});

  final int id;
  bool checked;
  bool completed;
  String str = "";

  @override
  Widget build(BuildContext context) {
    if (completed)
      str = 'This badge is \nalready completed!';
    else if (checked)
      str = 'This badge is \nin your list';
    else
      str = 'Add this badge \nto your list';
    return Row(
      children: [
        Text(
          str,
          textAlign: TextAlign.right,
          style: TextStyle(),
        ),
        SizedBox(
          width: 10,
        ),
        Checkbox(
          value: checked,
          onChanged: (val) async {
            if (completed) {
              setState(() {
                checked = true;
              });
            }
            String str = "";
            try {
              str = await FirebaseRunner.toggleAddedBadge(id, val!);
              if (str != "Done") throw Exception('Error!');
            } catch (e) {
              showDiag(
                  'Error',
                  'An unknown error has occurred. \nPlease try again',
                  context,
                  ['Ok'],
                  kColorXLightBlue,
                  kColorDarkBlue);
              //todo fix
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
