import 'package:flutter/material.dart';

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

const kColorXDarkBlue = Color.fromRGBO(12, 52, 69, 1);
const kColorDarkBlue = Color.fromRGBO(25, 105, 138, 1);
const kColorBlue = Color.fromRGBO(78, 211, 212, 1);
const kColorLightBlue = Color.fromRGBO(153, 255, 255, 1);
const kColorXLightBlue = Color.fromRGBO(228, 255, 255, 1);
const kColorXDarkPink = Color.fromRGBO(106, 39, 39, 1);
const kColorDarkPink = Color.fromRGBO(212, 79, 78, 1);
const kColorPink = Color.fromRGBO(255, 156, 145, 1);
const kColorLightPink = Color.fromRGBO(255, 217, 213, 1);
const kColorXLightPink = Color.fromRGBO(255, 236, 234, 1);

//---------------------------------------------------------------------------------------------

final kThemeLight = ThemeData(
  useMaterial3: true,
  primaryTextTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    labelLarge: TextStyle(color: Colors.white),
    displayLarge: TextStyle(
      fontSize: 45.0,
      fontWeight: FontWeight.w900,
      color: kColorDarkBlue,
    ),
    labelMedium: TextStyle(color: Colors.black),
    labelSmall: TextStyle(color: Colors.black),
  ),
  scaffoldBackgroundColor: kColorXLightBlue,
  primaryColor: kColorBlue,
  primaryColorLight: kColorLightBlue,
  primaryColorDark: kColorDarkBlue,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith(_getColor),
      backgroundColor:
          MaterialStateProperty.resolveWith((states) => kColorDarkBlue),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: kColorXLightPink,
  ),
  buttonTheme: ButtonThemeData(
      buttonColor: kColorDarkBlue, textTheme: ButtonTextTheme.normal),
  progressIndicatorTheme: ProgressIndicatorThemeData(color: kColorDarkBlue),
);

//------------------------------------------------------------------------------------------------------------------

final kThemeDark = ThemeData(
  useMaterial3: true,
  primaryTextTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    labelLarge: TextStyle(color: Colors.white),
    displayLarge: TextStyle(
      fontSize: 45.0,
      fontWeight: FontWeight.w900,
      color: kColorDarkBlue,
    ),
    labelMedium: TextStyle(color: Colors.black),
    labelSmall: TextStyle(color: Colors.black),
  ),
  scaffoldBackgroundColor: kColorXDarkBlue,
  primaryColor: kColorBlue,
  primaryColorLight: kColorLightBlue,
  primaryColorDark: kColorDarkBlue,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith(_getColor),
      backgroundColor:
          MaterialStateProperty.resolveWith((states) => kColorDarkBlue),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: kColorXLightPink,
  ),
  buttonTheme: ButtonThemeData(
      buttonColor: kColorDarkBlue, textTheme: ButtonTextTheme.normal),
  progressIndicatorTheme: ProgressIndicatorThemeData(color: kColorDarkBlue),
);
//borderRadius: BorderRadius.circular(30.0),
Color _getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return kColorLightBlue;
  }
  return Colors.white;
}
