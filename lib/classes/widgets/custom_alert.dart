import 'package:flutter/material.dart';

Future<String?> showDiag(String title, String mess, BuildContext c,
    List<String> list, Color back, Color textColor) {
  List<Widget> ac = [];

  for (String s in list) {
    ac.add(TextButton(
      onPressed: () => Navigator.of(c).pop(s),
      child: Text(
        s,
      ),
    ));
  }

  return showDialog<String>(
    context: c,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(mess),
      actions: ac,
      backgroundColor: back,
    ),
  );
}
