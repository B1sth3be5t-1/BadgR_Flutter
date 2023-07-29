import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: kColorLightBlue,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: kColorLightBlue, width: 2.0),
  ),
);

const kBorder = OutlineInputBorder(
  borderSide: BorderSide(color: kColorDarkBlue, width: 2.0),
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
);

const kBorderFocused = OutlineInputBorder(
  borderSide: BorderSide(color: kColorDarkBlue, width: 2.0),
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
);

const kBorderEnabled = OutlineInputBorder(
  borderSide: BorderSide(color: kColorDarkBlue, width: 1.0),
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
);

const kColorDarkBlue = Color.fromRGBO(25, 105, 138, 1);
const kColorBlue = Color.fromRGBO(78, 211, 212, 1);
const kColorLightBlue = Color.fromRGBO(153, 255, 255, 1);
const kColorXLightBlue = Color.fromRGBO(228, 255, 255, 1);
const kColorDarkPink = Color.fromRGBO(212, 79, 78, 1);
const kColorPink = Color.fromRGBO(255, 156, 145, 1);
const kColorLightPink = Color.fromRGBO(255, 217, 213, 1);
const kColorXLightPink = Color.fromRGBO(255, 236, 234, 1);
