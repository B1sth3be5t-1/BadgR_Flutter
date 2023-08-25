import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  CustomCheckbox({required this.id, required this.checked});

  final int id;
  final bool checked;

  _checkbox createState() => _checkbox(id: id, checked: checked);

  int getId() {
    return id;
  }

  bool getChecked() {
    return checked;
  }
}

class _checkbox extends State<CustomCheckbox> {
  _checkbox({required this.id, required this.checked});

  final int id;
  bool checked;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: checked,
      onChanged: (val) {
        setState(() {
          checked = val!;
        });
      },
    );
  }
}
