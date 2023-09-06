import 'package:flutter/material.dart';
import 'package:badgr/classes/themes.dart';

Widget CustomHeader(String s) {
  return Column(
    children: [
      Text(
        s,
        style: isLight()
            ? kThemeLight.primaryTextTheme.displayMedium
            : kThemeDark.primaryTextTheme.displayMedium,
      ),
      SizedBox(
        child: Padding(
          padding: EdgeInsets.only(top: 7, bottom: 5, right: 50, left: 50),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: isLight()
                  ? kThemeLight.primaryTextTheme.displayMedium?.color
                  : kThemeDark.primaryTextTheme.displayMedium?.color,
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
