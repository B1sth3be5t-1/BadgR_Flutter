import 'package:badgr/classes/colors_and_themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:rounded_background_text/rounded_background_text.dart';

import '../colors_and_themes/color_schemes.g.dart';

class CustomPercentageIndicator extends StatefulWidget {
  CustomPercentageIndicator({this.title, required this.percent});

  final String? title;
  final double percent;

  @override
  _CAHState createState() => _CAHState(title: title, percent: percent);
}

class _CAHState extends State<CustomPercentageIndicator> {
  _CAHState({required this.title, required this.percent});

  final String? title;
  double percent;

  @override
  Widget build(BuildContext context) {
    TextStyle? style = Theme.of(context).primaryTextTheme.displaySmall;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: LinearPercentIndicator(
        barRadius: Radius.circular(7.5),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: title == null
              ? null
              : Text(
                  title!,
                  style: style,
                ),
        ),
        center: Center(
          child: RoundedBackgroundText(
            percent < 1 ? '${(percent * 100).toInt()}%' : 'Complete!',
            backgroundColor: LinProgTheme.backgroundColor,
            style: style?.copyWith(color: LinProgTheme.textColor),
          ),
        ),
        width: 139,
        lineHeight: 35.0,
        animation: true,
        animationDuration: 600,
        percent: percent,
        backgroundColor: LinProgTheme.backgroundColor,
        progressColor: LinProgTheme.progressColor,
      ),
    );
  }
}
