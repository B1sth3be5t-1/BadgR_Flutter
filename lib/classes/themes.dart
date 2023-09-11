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
  ),
  scaffoldBackgroundColor: kColorXLightBlue,
  primaryColor: kColorBlue,
  primaryColorLight: kColorLightBlue,
  primaryColorDark: kColorDarkBlue,
  primaryTextTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
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
  primaryTextTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
    labelLarge: TextStyle(color: Colors.white),
    displayLarge: TextStyle(
      fontSize: 45.0,
      fontWeight: FontWeight.w900,
      color: kColorBlue,
    ),
    labelMedium: TextStyle(color: Colors.white),
    labelSmall: TextStyle(color: Colors.white),
  ),
  listTileTheme: ListTileThemeData(
      tileColor: kColorPink,
      selectedTileColor: kColorLightPink,
      selectedColor: kColorXDarkBlue),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.white70),
    hintStyle: const TextStyle(
      color: Colors.white54,
    ),
    errorStyle: const TextStyle(
      color: kColorDarkPink,
    ),
    contentPadding:
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: kBorder,
    enabledBorder: kBorderEnabled,
    focusedBorder: kBorderFocused,
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
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) => kColorBlue),
    checkColor: MaterialStateProperty.resolveWith((states) => Colors.white),
    overlayColor:
        MaterialStateProperty.resolveWith((states) => kColorLightBlue),
    splashRadius: 17,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    hoverColor: kColorLightBlue,
    backgroundColor: kColorBlue,
  ),
);

class AlertDiagTheme {
  static Color backgroundColor = isLight() ? kColorXLightBlue : kColorBlue;
  static Color textColor = isLight() ? kColorDarkBlue : kColorXLightBlue;
}

class AccordionTheme {
  static Color headerBackgroundColor = isLight() ? kColorLightPink : kColorPink;
  static Color headerBackgroundColorOpened =
      isLight() ? kColorBlue : kColorLightPink;
  static Color contentBackgroundColor = getBackgroundColor();
  static Color contentBorderColor =
      isLight() ? kColorDarkBlue : kColorLightPink;
}

class linProgTheme {
  static Color backgroundColor = !isLight() ? kColorLightBlue : kColorPink;
  static Color progressColor = !isLight() ? kColorDarkPink : kColorDarkBlue;
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
