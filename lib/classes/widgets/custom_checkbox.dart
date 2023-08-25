import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: checked,
      onChanged: (val) {
        setState(() {
          checked = val!;
        });
      }, //todo onChanged if completed
    );
  }
}
