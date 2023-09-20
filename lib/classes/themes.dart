import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

bool _isLight = true;

void switchTheme(BuildContext c) {
  if (_isLight) {
    AdaptiveTheme.of(c).setDark();
    _isLight = false;
  } else {
    AdaptiveTheme.of(c).setLight();
    _isLight = true;
  }
}

Color getBackgroundColor() {
  return _isLight
      ? kThemeLight.scaffoldBackgroundColor
      : kThemeDark.scaffoldBackgroundColor;
}

final kThemeLight = ThemeData(
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    backgroundColor: kColorXLightPink,
  ),
  buttonTheme: ButtonThemeData(
      buttonColor: kColorDarkBlue, textTheme: ButtonTextTheme.normal),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) => kColorBlue),
    checkColor: MaterialStateProperty.resolveWith((states) => Colors.white),
    overlayColor:
        MaterialStateProperty.resolveWith((states) => kColorLightBlue),
    splashRadius: 17,
    side: BorderSide(width: 1.5, color: Colors.black),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    hoverColor: kColorLightBlue,
    backgroundColor: kColorBlue,
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStateProperty.resolveWith((states) => kColorDarkBlue),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.black),
    hintStyle: const TextStyle(
      color: Colors.grey,
    ),
    errorStyle: const TextStyle(
      color: kColorDarkPink,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    contentPadding:
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: kBorder,
    enabledBorder: kBorderEnabled,
    focusedBorder: kBorderFocused,
  ),
  listTileTheme: ListTileThemeData(
      tileColor: kColorLightPink,
      selectedTileColor: kColorBlue,
      selectedColor: kColorXLightBlue),
  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: kColorBlue,
    backgroundColor: kColorLightPink,
    labelTextStyle: MaterialStateProperty.resolveWith(
        (states) => TextStyle(color: Colors.black)),
  ),
  scaffoldBackgroundColor: kColorXLightBlue,
  primaryColor: kColorBlue,
  primaryColorLight: kColorLightBlue,
  primaryColorDark: kColorDarkBlue,
  primaryTextTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(fontSize: 20, color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
    displayLarge: TextStyle(
      fontSize: 45.0,
      fontWeight: FontWeight.w900,
      color: kColorDarkBlue,
    ),
    displayMedium: TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      color: kColorDarkBlue,
    ),
    displaySmall: TextStyle(
      color: kColorDarkBlue,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
    headlineLarge: TextStyle(
      color: kColorDarkBlue,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(color: kColorDarkBlue, fontSize: 18),
    labelLarge: TextStyle(color: Colors.white),
    labelMedium: TextStyle(color: Colors.black),
    labelSmall: TextStyle(color: Colors.black),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(color: kColorDarkBlue),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith(_getColor),
      backgroundColor:
          MaterialStateProperty.resolveWith((states) => kColorDarkBlue),
    ),
  ),
);

//------------------------------------------------------------------------------------------------------------------

final kThemeDark = ThemeData(
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    backgroundColor: kColorLightPink,
  ),
  buttonTheme: ButtonThemeData(
      buttonColor: kColorDarkBlue, textTheme: ButtonTextTheme.normal),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) => kColorBlue),
    checkColor: MaterialStateProperty.resolveWith((states) => Colors.white),
    overlayColor:
        MaterialStateProperty.resolveWith((states) => kColorLightBlue),
    splashRadius: 17,
    side: BorderSide(width: 1.5, color: Colors.white),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    hoverColor: kColorLightBlue,
    backgroundColor: kColorBlue,
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStateProperty.resolveWith(
        (states) => kColorDarkBlue,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.white70),
    hintStyle: const TextStyle(
      color: Colors.white60,
    ),
    errorStyle: const TextStyle(
      color: kColorDarkPink,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    contentPadding:
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: kBorder,
    enabledBorder: kBorderEnabled,
    focusedBorder: kBorderFocused,
  ),
  listTileTheme: ListTileThemeData(
      tileColor: kColorPink,
      selectedTileColor: kColorLightPink,
      selectedColor: kColorXDarkBlue),
  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: kColorBlue,
    backgroundColor: kColorDarkBlue,
    labelTextStyle: MaterialStateProperty.resolveWith(
        (states) => TextStyle(color: Colors.white)),
  ),
  scaffoldBackgroundColor: kColorXDarkBlue,
  primaryColor: kColorBlue,
  primaryColorLight: kColorLightBlue,
  primaryColorDark: kColorDarkBlue,
  primaryTextTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(fontSize: 20, color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
    displayLarge: TextStyle(
      fontSize: 45.0,
      fontWeight: FontWeight.w900,
      color: kColorKindaDarkBlue,
    ),
    displayMedium: TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      color: kColorLightPink,
    ),
    displaySmall: TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
    headlineLarge: TextStyle(
        color: kColorDarkBlue, fontSize: 20, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(color: kColorLightPink, fontSize: 18),
    labelLarge: TextStyle(color: Colors.white),
    labelMedium: TextStyle(color: Colors.white),
    labelSmall: TextStyle(color: Colors.white),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(color: kColorDarkBlue),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith(_getColor),
      backgroundColor:
          MaterialStateProperty.resolveWith((states) => kColorDarkBlue),
    ),
  ),
);

class AlertDiagTheme {
  static Color backgroundColor = isLight() ? kColorXLightBlue : kColorBlue;
  static Color textColor = isLight() ? kColorDarkBlue : kColorXLightBlue;
}

class AccordionTheme {
  static Color headerBackgroundColor = kColorLightPink;
  static Color headerBackgroundColorOpened =
      isLight() ? kColorBlue : kColorBlue;
  static Color contentBackgroundColor = getBackgroundColor();
  static Color contentBorderColor =
      isLight() ? kColorDarkBlue : kColorLightPink;
  static Color customAccBackColor =
      isLight() ? kColorLightPink : kColorKindaLightPink;
}

class LinProgTheme {
  static Color backgroundColor = isLight() ? kColorPink : kColorXLightBlue;
  static Color progressColor = isLight() ? kColorDarkBlue : kColorBlue;

  static Color textColor(double p) {
    if (!isLight()) return Colors.black;
    if (p < .45) return Colors.black;
    return Colors.white;
  }
}

class NavigationIconTheme {
  static Color iconColor = isLight() ? Colors.black : Colors.white;
  static Color textColor = isLight() ? Colors.black : Colors.white;
}

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

bool isLight() {
  return _isLight;
}

void setLight(bool b) {
  _isLight = b;
}
