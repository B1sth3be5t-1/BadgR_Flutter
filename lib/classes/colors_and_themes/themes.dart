import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:badgr/classes/colors_and_themes/color_schemes.g.dart';
import 'package:badgr/classes/colors_and_themes/custom_color.g.dart';
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
    backgroundColor: lightColorScheme.tertiary,
  ),
  buttonTheme: ButtonThemeData(buttonColor: lightColorScheme.primary),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith(
        (states) => lightColorScheme.onTertiaryContainer),
    checkColor: MaterialStateProperty.resolveWith((states) => Colors.white),
    overlayColor: MaterialStateProperty.resolveWith(
        (states) => lightColorScheme.tertiary),
    splashRadius: 17,
    side: BorderSide(width: 1.5, color: Colors.black),
  ),
  colorScheme: lightColorScheme,
  extensions: [lightCustomColors.harmonized(lightColorScheme)],
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    hoverColor: lightColorScheme.onTertiary,
    backgroundColor: lightColorScheme.tertiary,
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStateProperty.resolveWith(
          (states) => lightColorScheme.onTertiary),
    ),
  ),
  iconTheme: IconThemeData(
    color: lightColorScheme.onTertiary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.black),
    hintStyle: TextStyle(
      color: lightColorScheme.onPrimaryContainer,
      overflow: TextOverflow.fade,
    ),
    errorStyle: TextStyle(
      color: lightColorScheme.error,
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
      //todo not sure if this is used
      tileColor: kColorLightPink,
      selectedTileColor: kColorBlue,
      selectedColor: kColorXLightBlue),
  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: lightColorScheme.onTertiaryContainer,
    backgroundColor: lightColorScheme.tertiary,
    labelTextStyle: MaterialStateProperty.resolveWith(
      (states) => TextStyle(color: lightColorScheme.onTertiary),
    ),
  ),
  scaffoldBackgroundColor: lightColorScheme.primaryContainer,
  primaryTextTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(
        fontSize: 20,
        color: lightColorScheme.onPrimaryContainer), // search page
    bodySmall: TextStyle(
        color: lightColorScheme.onPrimaryContainer), // search checkbox
    displayLarge: TextStyle(
      // BadgR Title
      fontSize: 45.0,
      fontWeight: FontWeight.w900,
      color: lightColorScheme.onPrimaryContainer,
    ),
    displayMedium: TextStyle(
      // main pages welcome, CustomHeader
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      color: lightColorScheme.onTertiary,
    ),
    displaySmall: TextStyle(
      color: lightColorScheme.onSecondary,
      fontSize: 15,
      fontWeight: FontWeight.bold, //accordion header stuff
    ),
    headlineLarge: TextStyle(
      color: kColorDarkBlue,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
        color: lightColorScheme.onPrimaryContainer, fontSize: 18), //home pages
    labelLarge: TextStyle(color: Colors.white),
    labelMedium: TextStyle(color: Colors.black),
    labelSmall: TextStyle(color: Colors.black),
  ),
  progressIndicatorTheme:
      ProgressIndicatorThemeData(color: lightColorScheme.primary),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith(_getColor),
      backgroundColor: MaterialStateProperty.resolveWith(
          (states) => lightColorScheme.primary),
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
    fillColor: MaterialStateProperty.resolveWith(
        (states) => lightColorScheme.onTertiaryContainer),
    checkColor: MaterialStateProperty.resolveWith((states) => Colors.white),
    overlayColor: MaterialStateProperty.resolveWith(
        (states) => lightColorScheme.onTertiaryContainer),
    splashRadius: 17,
    side: BorderSide(width: 1.5, color: Colors.white),
  ),
  colorScheme: darkColorScheme,
  extensions: [darkCustomColors.harmonized(darkColorScheme)],
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
  iconTheme: IconThemeData(
    color: kColorLightBlue,
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
  scaffoldBackgroundColor: darkColorScheme.primaryContainer,
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
      color: darkColorScheme.onPrimaryContainer, // here is BadgR
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
  static Color headerBackgroundColor =
      isLight() ? lightColorScheme.secondary : kColorBlue;
  static Color headerBackgroundColorOpened =
      isLight() ? lightColorScheme.tertiary : kColorBlue;
  static Color contentBackgroundColor = getBackgroundColor();
  static Color contentBorderColor =
      isLight() ? lightColorScheme.tertiary : kColorLightPink;
  static Color customAccBackColor =
      isLight() ? lightColorScheme.tertiaryContainer : kColorKindaLightPink;
  static Color customAccTextColor =
      isLight() ? lightColorScheme.onTertiaryContainer : kColorDarkBlue;
}

class CustomCheckBoxTheme {
  static Color checkColor(bool c) {
    if (c)
      return isLight() ? lightColorScheme.onTertiaryContainer : kColorDarkBlue;
    return isLight() ? Colors.white : kColorDarkBlue;
  }
}

class LinProgTheme {
  static Color backgroundColor =
      isLight() ? lightColorScheme.inversePrimary : kColorXLightBlue;
  static Color progressColor =
      isLight() ? lightColorScheme.onPrimaryContainer : kColorBlue;
  static Color textColor =
      isLight() ? lightColorScheme.onPrimaryContainer : kColorDarkBlue;
}

class NavigationIconTheme {
  static Color iconColor(BuildContext c) => Theme.of(c).colorScheme.onTertiary;
  static Color textColor(BuildContext c) => Theme.of(c).colorScheme.onTertiary;
}

Color _getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return lightColorScheme.inversePrimary;
  }
  return Colors.white;
}

bool isLight() {
  return _isLight;
}

void setLight(bool b) {
  _isLight = b;
}
