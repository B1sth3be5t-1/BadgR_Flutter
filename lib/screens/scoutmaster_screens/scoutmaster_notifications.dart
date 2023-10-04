import 'package:badgr/classes/colors_and_themes/color_schemes.g.dart';
import 'package:badgr/classes/firebase_runner.dart';
import 'package:badgr/classes/widgets/custom_alert.dart';
import 'package:badgr/classes/widgets/custom_page_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:accordion/accordion.dart';
import '../../classes/colors_and_themes/themes.dart';

class ScoutmasterNotifications extends StatefulWidget {
  const ScoutmasterNotifications({super.key});

  @override
  // ignore: library_private_types_in_public_api
  ScoutmasterNotificationsState createState() =>
      ScoutmasterNotificationsState();
}

class ScoutmasterNotificationsState extends State<ScoutmasterNotifications> {
  final List<CustomIconCloseButton> checks = [];

  @override
  Widget build(BuildContext context) {
    final _headerStyle = TextStyle(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        fontSize: 20,
        fontWeight: FontWeight.bold);
    return Scaffold(
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomHeader('Notifications', context),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseRunner.notificationsStream(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Container(
                          height: 100,
                          child: ModalProgressHUD(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            inAsyncCall: true,
                            child: Text(''),
                          ),
                        ),
                      );
                    } else if (!snapshot.hasData) {
                      return Text('noData');
                    } else if (snapshot.hasError) {
                      return Text('error');
                    } else if (snapshot.data?.docs.length == 0) {
                      return Center(
                        child: Text(
                          'There are no new notifications',
                          style: _headerStyle,
                        ),
                      );
                    }

                    List<AccordionSection> lis = [];
                    checks.clear();

                    //get map of docSnapshots (aka the added badges)
                    Map<int, QueryDocumentSnapshot<Object?>> docMap =
                        snapshot.data!.docs.toList().asMap();

                    for (MapEntry<int, QueryDocumentSnapshot<Object?>> me
                        in docMap.entries) {
                      QueryDocumentSnapshot? docData = me.value;

                      Timestamp t = docData['timestamp'] as Timestamp;
                      DateTime date = t.toDate();
                      DateTime d = DateTime(date.year, date.month, date.day,
                          date.hour, date.minute);

                      String name = docData['name'];
                      String type = docData['type'];
                      String desc = docData['desc'];

                      String dateString = d.toString();
                      String label =
                          dateString.substring(0, dateString.length - 7);

                      checks.add(CustomIconCloseButton(
                          name: name, type: type, desc: desc));

                      lis.add(
                        AccordionSection(
                          accordionId: d.toString(),
                          header: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              'Notification Date: $label',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .displaySmall,
                            ),
                          ),
                          content: Row(
                            children: [
                              Expanded(
                                child: Icon(
                                  type == 'badge'
                                      ? Icons.check
                                      : Icons.person_add_alt_1,
                                  color: AccordionTheme.customAccTextColor(),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  type == 'badge'
                                      ? '$name has completed the merit badge: $desc'
                                      : '$name has been added to your troop!',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .labelSmall
                                      ?.copyWith(
                                          fontSize: 15,
                                          color: AccordionTheme
                                              .customAccTextColor()),
                                ),
                              ),
                              Expanded(
                                child: checks[checks.length - 1],
                              )
                            ],
                          ),
                        ),
                      );
                    }

                    lis.sort((AccordionSection a, AccordionSection b) {
                      DateTime a1 = DateTime.parse(a.accordionId!);
                      DateTime b1 = DateTime.parse(b.accordionId!);

                      return a1.difference(b1).inMinutes;
                    });

                    Accordion acc = Accordion(
                      disableScrolling: true,
                      maxOpenSections: 1,
                      children: lis,
                      headerBackgroundColor:
                          AccordionTheme.headerBackgroundColor(),
                      contentBorderColor: AccordionTheme.contentBorderColor(),
                      contentBackgroundColor:
                          AccordionTheme.contentBackgroundColor(),
                      headerBackgroundColorOpened:
                          AccordionTheme.headerBackgroundColorOpened(),
                    );

                    return acc;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDiag('Confirm',
            'Are you sure you want to clear all notifications?', context, [
          'No',
          'Yes'
        ]).then((value) => {
              if (value == null)
                null
              else if (value == 'Yes')
                for (CustomIconCloseButton c in checks) c.removeNot()
            }),
        child: Icon(
          Icons.clear,
          color: isLight()
              ? lightColorScheme.onTertiary
              : darkColorScheme.onTertiary,
        ),
        tooltip: 'Clear all',
      ),
    );
  }
}

class CustomIconCloseButton extends StatelessWidget {
  CustomIconCloseButton(
      {required this.name, required this.type, required this.desc});

  final String name, type, desc;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () =>
          FirebaseRunner.removeNotification(type: type, name: name, desc: desc),
      icon: Icon(
        Icons.close,
        color: AccordionTheme.customAccTextColor(),
      ),
      tooltip: 'Remove Notification',
    );
  }

  void removeNot() {
    FirebaseRunner.removeNotification(type: type, name: name, desc: desc);
  }
}
