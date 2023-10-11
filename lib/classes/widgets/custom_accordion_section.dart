import 'dart:async';
import 'dart:math';

import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badgr/classes/colors_and_themes/themes.dart';

class CustomAccordionSection extends StatelessWidget with CommonParams {
  final SectionController sectionCtrl = SectionController();
  late final UniqueKey uniqueKey;
  late final int index;
  final bool isOpen;

  /// Callback function for when a section opens
  final Function? onOpenSection;

  /// Callback functionf or when a section closes
  final Function? onCloseSection;

  /// The text to be displayed in the header
  final Widget header;

  CustomAccordionSection({
    Key? key,
    this.index = 0,
    this.isOpen = false,
    required this.header,
    Color? headerBackgroundColor,
    Color? headerBorderColor,
    Color? headerBorderColorOpened,
    double? headerBorderWidth,
    double? headerBorderRadius,
    EdgeInsets? headerPadding,
    Widget? leftIcon,
    Widget? rightIcon,
    double? paddingBetweenOpenSections,
    double? paddingBetweenClosedSections,
    ScrollIntoViewOfItems? scrollIntoViewOfItems,
    SectionHapticFeedback? sectionOpeningHapticFeedback,
    SectionHapticFeedback? sectionClosingHapticFeedback,
    String? accordionId,
    this.onOpenSection,
    this.onCloseSection,
  }) : super(key: key) {
    final listCtrl = Get.put(ListController(), tag: accordionId);
    uniqueKey = listCtrl.keys.elementAt(index);
    sectionCtrl.isSectionOpen.value = listCtrl.openSections.contains(uniqueKey);

    this.headerBackgroundColor = headerBackgroundColor;
    this.headerBorderRadius = headerBorderRadius;
    this.headerPadding = headerPadding;
    this.leftIcon = leftIcon;
    this.rightIcon = rightIcon;
    this.paddingBetweenOpenSections = paddingBetweenOpenSections;
    this.paddingBetweenClosedSections = paddingBetweenClosedSections;
    this.scrollIntoViewOfItems =
        scrollIntoViewOfItems ?? ScrollIntoViewOfItems.fast;
    this.sectionOpeningHapticFeedback = sectionOpeningHapticFeedback;
    this.sectionClosingHapticFeedback = sectionClosingHapticFeedback;
    this.accordionId = accordionId;

    listCtrl.controllerIsOpen.stream.asBroadcastStream().listen((data) {
      sectionCtrl.isSectionOpen.value = listCtrl.openSections.contains(key);
    });
  }

  /// getter indication the open or closed status of this section
  get _isOpen {
    final listCtrl = Get.put(ListController(), tag: accordionId);
    final open = sectionCtrl.isSectionOpen.value;

    Timer(
      sectionCtrl.firstRun
          ? (listCtrl.initialOpeningSequenceDelay + min(index * 200, 1000))
              .milliseconds
          : 0.seconds,
      () {
        if (Accordion.sectionAnimation) {
          sectionCtrl.controller
              .fling(velocity: open ? 1 : -1, springDescription: springFast);
        } else {
          sectionCtrl.controller.value = open ? 1 : 0;
        }
        sectionCtrl.firstRun = false;
      },
    );

    return open;
  }

  @override
  build(context) {
    final borderRadius = headerBorderRadius ?? 10;

    return Obx(
      () => Column(
        key: uniqueKey,
        children: [
          InkWell(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(borderRadius),
              bottom: Radius.circular(_isOpen ? 0 : borderRadius),
            ),
            child: AnimatedContainer(
              duration: Accordion.sectionAnimation
                  ? 750.milliseconds
                  : 0.milliseconds,
              curve: Curves.easeOut,
              alignment: Alignment.center,
              padding: headerPadding,
              decoration: BoxDecoration(
                color:
                    (_isOpen ? headerBackgroundColor : headerBackgroundColor) ??
                        Theme.of(context).primaryColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(borderRadius),
                  bottom: Radius.circular(_isOpen ? 0 : borderRadius),
                ),
                border: Border.all(
                  color: AccordionTheme.headerBackgroundColor(),
                  width: (10),
                  style: (0) <= 0 ? BorderStyle.none : BorderStyle.solid,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: leftIcon == null ? 0 : 15),
                      child: header,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
