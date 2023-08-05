import 'package:flutter/material.dart';

Widget CustomHeader(String s, Color c) {
  return Column(
    children: [
      Text(
        s,
        style: TextStyle(fontSize: 30, color: c, fontWeight: FontWeight.bold),
      ),
      SizedBox(
        child: Padding(
          padding: EdgeInsets.only(top: 7, bottom: 5),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        height: 19,
        width: 1000,
      ),
    ],
  );
}
