import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:BadgR/classes/colors_and_themes/color_schemes.g.dart';
import 'package:BadgR/classes/colors_and_themes/custom_color.g.dart';
import 'package:flutter/material.dart';

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
    hoverElevation: 5,
    hoverColor: lightColorScheme.primary,
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
    bodyMedium:
        TextStyle(fontSize: 20, color: lightColorScheme.onPrimaryContainer),
    // search page
    bodySmall: TextStyle(color: lightColorScheme.onPrimaryContainer),
    // search checkbox
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
      // scoutmaster my troop
      color: AccordionTheme.customAccTextColor(),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium:
        TextStyle(color: lightColorScheme.onPrimaryContainer, fontSize: 18),
    //home pages
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
    backgroundColor: darkColorScheme.tertiary,
  ),
  buttonTheme: ButtonThemeData(buttonColor: darkColorScheme.primary),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith(
        (states) => darkColorScheme.onTertiaryContainer),
    checkColor: MaterialStateProperty.resolveWith((states) => Colors.black),
    overlayColor:
        MaterialStateProperty.resolveWith((states) => darkColorScheme.tertiary),
    splashRadius: 17,
    side: BorderSide(width: 1.5, color: Colors.white),
  ),
  colorScheme: darkColorScheme,
  extensions: [lightCustomColors.harmonized(darkColorScheme)],
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    hoverColor: darkColorScheme.onTertiaryContainer,
    backgroundColor: darkColorScheme.tertiary,
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: MaterialStateProperty.resolveWith(
          (states) => darkColorScheme.onTertiary),
    ),
  ),
  iconTheme: IconThemeData(
    color: darkColorScheme.onTertiary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.black),
    hintStyle: TextStyle(
      color: darkColorScheme.onPrimaryContainer,
      overflow: TextOverflow.fade,
    ),
    errorStyle: TextStyle(
      color: darkColorScheme.error,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    contentPadding:
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: kBorder,
    enabledBorder: kBorderEnabled,
    focusedBorder: kBorderFocused,
  ),
  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: darkColorScheme.onTertiaryContainer,
    backgroundColor: darkColorScheme.tertiary,
    labelTextStyle: MaterialStateProperty.resolveWith(
      (states) => TextStyle(color: darkColorScheme.onTertiary),
    ),
  ),
  scaffoldBackgroundColor: darkColorScheme.primaryContainer,
  primaryTextTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium:
        TextStyle(fontSize: 20, color: darkColorScheme.onPrimaryContainer),
    // search page
    bodySmall: TextStyle(color: darkColorScheme.onPrimaryContainer),
    // search checkbox
    displayLarge: TextStyle(
      // BadgR Title
      fontSize: 45.0,
      fontWeight: FontWeight.w900,
      color: darkColorScheme.onPrimaryContainer,
    ),
    displayMedium: TextStyle(
      // main pages welcome, CustomHeader
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      color: darkColorScheme.onTertiary,
    ),
    displaySmall: TextStyle(
      color: darkColorScheme.onSecondary,
      fontSize: 15,
      fontWeight: FontWeight.bold, //accordion header stuff
    ),
    headlineLarge: TextStyle(
      color: AccordionTheme.customAccTextColor(),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium:
        TextStyle(color: darkColorScheme.onPrimaryContainer, fontSize: 18),
    //home pages
    labelLarge: TextStyle(color: Colors.white),
    labelMedium: TextStyle(color: Colors.white),
    labelSmall: TextStyle(color: Colors.white),
  ),
  progressIndicatorTheme:
      ProgressIndicatorThemeData(color: darkColorScheme.primary),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith(_getColor),
      backgroundColor: MaterialStateProperty.resolveWith(
          (states) => darkColorScheme.primary),
    ),
  ),
);

class AlertDiagTheme {
  static Color backgroundColor() => isLight()
      ? lightColorScheme.tertiaryContainer
      : darkColorScheme.tertiaryContainer;

  static Color textColor() => isLight()
      ? lightColorScheme.onTertiaryContainer
      : darkColorScheme.onTertiaryContainer;
}

class AccordionTheme {
  static Color headerBackgroundColor() =>
      isLight() ? lightColorScheme.secondary : darkColorScheme.primary;

  static Color headerBackgroundColorOpened() =>
      isLight() ? lightColorScheme.tertiary : darkColorScheme.tertiary;

  static Color contentBackgroundColor() => getBackgroundColor();

  static Color contentBorderColor() =>
      isLight() ? lightColorScheme.tertiary : darkColorScheme.tertiary;

  static Color customAccBackColor() => isLight()
      ? lightColorScheme.tertiaryContainer
      : darkColorScheme.tertiaryContainer;

  static Color customAccTextColor() => isLight()
      ? lightColorScheme.onTertiaryContainer
      : darkColorScheme.onTertiaryContainer;
}

class CustomSwitchTheme {
  static Color activeTrackColor = isLight()
      ? lightColorScheme.onTertiaryContainer
      : darkColorScheme.onTertiaryContainer;
  static Color activeColor = isLight() ? Colors.white : Colors.black;
  static Color inactiveColor =
      isLight() ? lightColorScheme.secondary : darkColorScheme.primary;
  static Color inactiveTrackColor = isLight()
      ? lightColorScheme.primaryContainer
      : darkColorScheme.primaryContainer;
}

class LinProgTheme {
  static Color backgroundColor() => isLight()
      ? lightColorScheme.inversePrimary
      : darkColorScheme.inversePrimary;

  static Color progressColor() => isLight()
      ? lightColorScheme.onPrimaryContainer
      : darkColorScheme.onTertiary;

  static Color textColor() => isLight()
      ? lightColorScheme.onPrimaryContainer
      : darkColorScheme.onPrimaryContainer;
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
    return isLight()
        ? lightColorScheme.inversePrimary
        : darkColorScheme.inversePrimary;
  }
  return isLight() ? Colors.white : Colors.black;
}

bool isLight() {
  return _isLight;
}

void setLight(bool b) {
  _isLight = b;
}

final kBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.black, width: 2.0),
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
);

final kBorderFocused = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.black, width: 4.0),
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
);

final kBorderEnabled = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.black, width: 1.0),
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
);
