import 'package:flutter/material.dart';
import 'package:BadgR/classes/colors_and_themes/themes.dart';

Widget CustomHeader(String s, BuildContext context) {
  Color c = Theme.of(context).colorScheme.onPrimaryContainer;

  return Column(
    children: [
      Text(
        s,
        style: isLight()
            ? kThemeLight.primaryTextTheme.displayMedium?.copyWith(color: c)
            : kThemeDark.primaryTextTheme.displayMedium?.copyWith(color: c),
      ),
      SizedBox(
        child: Padding(
          padding: EdgeInsets.only(top: 7, bottom: 5, right: 50, left: 50),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        height: 19,
        width: MediaQuery.of(context).size.width,
      ),
    ],
  );
}
