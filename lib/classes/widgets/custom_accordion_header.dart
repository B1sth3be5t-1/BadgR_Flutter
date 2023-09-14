import 'package:badgr/classes/themes.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CustomAccordionHeader extends StatefulWidget {
  CustomAccordionHeader({required this.title, required this.percent});

  final String title;
  final double percent;

  @override
  _CAHState createState() => _CAHState(title: title, percent: percent);
}

class _CAHState extends State<CustomAccordionHeader> {
  _CAHState({required this.title, required this.percent});

  final String title;
  double percent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: LinearPercentIndicator(
        barRadius: Radius.circular(7.5),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            title,
            style: Theme.of(context).primaryTextTheme.displaySmall,
          ),
        ),
        center: percent < .45
            ? Text(
                '${(percent * 100).toInt()}%',
                style: TextStyle(
                  color: LinProgTheme.textColor(percent),
                ),
              )
            : percent < 1
                ? Text(
                    '${(percent * 100).toInt()}%',
                    style: TextStyle(
                      color: LinProgTheme.textColor(percent),
                    ),
                  )
                : Text(
                    'Complete!',
                    style: TextStyle(
                      color: LinProgTheme.textColor(percent),
                    ),
                  ),
        width: 196,
        lineHeight: 20.0,
        animation: true,
        animationDuration: 600,
        percent: percent,
        backgroundColor: LinProgTheme.backgroundColor,
        progressColor: LinProgTheme.progressColor,
      ),
    );
  }
}
