import 'package:badgr/classes/firebase_runner.dart';
import 'package:badgr/classes/widgets/custom_page_header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:accordion/accordion.dart';

import '../../classes/constants.dart';
import '../../classes/themes.dart';

class ScoutmasterNotifications extends StatefulWidget {
  const ScoutmasterNotifications({super.key});

  @override
  // ignore: library_private_types_in_public_api
  ScoutmasterNotificationsState createState() =>
      ScoutmasterNotificationsState();
}

class ScoutmasterNotificationsState extends State<ScoutmasterNotifications> {
  final _headerStyle = TextStyle(
      color: isLight() ? kColorDarkBlue : kColorDarkBlue,
      fontSize: 20,
      fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              CustomHeader('Notifications'),
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

                    lis.add(
                      AccordionSection(
                        accordionId: d.toString(),
                        header: Text(
                          'Notification Date: $label',
                          style:
                              Theme.of(context).primaryTextTheme.displaySmall,
                        ),
                        content: Row(
                          children: [
                            Expanded(
                              child: Icon(
                                docData['type'] == 'badge'
                                    ? Icons.check
                                    : Icons.person_add_alt_1,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: docData['type'] == 'badge'
                                  ? Text(
                                      '$name has completed the merit badge: $desc',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .displaySmall,
                                    )
                                  : Text(
                                      '$name has been added to your troop!',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .displaySmall,
                                    ),
                            ),
                            Expanded(
                              child: CustomIconCloseButton(
                                  name: name, type: type, desc: desc),
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
                    children: lis,
                    headerBackgroundColor: AccordionTheme.headerBackgroundColor,
                    contentBorderColor: AccordionTheme.contentBorderColor,
                    contentBackgroundColor:
                        AccordionTheme.contentBackgroundColor,
                    headerBackgroundColorOpened:
                        AccordionTheme.headerBackgroundColorOpened,
                  );

                  return acc;
                },
              ),
            ],
          ),
        ),
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
      icon: Icon(Icons.close),
      tooltip: 'Remove Notification',
    );
  }
}
