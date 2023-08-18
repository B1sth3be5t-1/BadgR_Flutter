import 'package:accordion/accordion.dart';
import 'package:badgr/classes/constants.dart';
import 'package:badgr/classes/merit_badge_info.dart';
import 'package:badgr/classes/firebase_runner.dart';
import 'package:flutter/material.dart';
import 'package:badgr/classes/widgets/custom_input.dart';
import 'package:badgr/classes/widgets/custom_header.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ScoutSearch extends StatefulWidget {
  const ScoutSearch({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScoutSearchState createState() => _ScoutSearchState();
}

class _ScoutSearchState extends State<ScoutSearch> {
  final _headerStyle = const TextStyle(
      color: kColorDarkBlue, fontSize: 15, fontWeight: FontWeight.bold);
  final TextEditingController _tec = TextEditingController();
  Widget Acc = Text(
    'Enter a search word',
    style: const TextStyle(
        color: kColorDarkBlue, fontSize: 15, fontWeight: FontWeight.bold),
  );
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              CustomHeader('Search', kColorDarkBlue),
              Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    flex: 5,
                    child: CustomFormField(
                        labelText: 'Badge Name',
                        controller: _tec,
                        hintText: 'Enter a full or partial badge name',
                        obscureText: false),
                  ),
                  Expanded(
                    flex: 1,
                    child: Material(
                      color: kColorDarkBlue,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      elevation: 5.0,
                      child: TextButton(
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          Widget a = await buildAccordion();
                          setState(() {
                            Acc = a;
                          });
                        },
                        child: Text(
                          'Search',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Acc
            ],
          ),
        ),
      ),
    );
  }

  Future<Widget> buildAccordion() async {
    setState(() {
      showSpinner = true;
    });
    List<AccordionSection> lis = [];
    List<MeritBadge> mbs = FirebaseRunner.getSearchResults(_tec.text);

    for (MeritBadge mb in mbs) {
      AccordionSection AS = AccordionSection(
          header: Text(
            mb.name,
            style: _headerStyle,
          ),
          content: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 2,
                child: Text('Todo'), //Image.asset('images/badges/${mb.name}'),
              ),
              Expanded(
                child: SizedBox(
                  width: 10,
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  mb.name,
                  textAlign: TextAlign.left,
                  style: TextStyle(),
                ),
              ),
              Expanded(
                child: Checkbox(
                  value: false,
                  onChanged: (val) {}, //todo a lot of stuff here
                ),
              ),
            ],
          ));

      lis.add(AS);
    }

    Widget acc = Accordion(
      maxOpenSections: 20,
      headerBackgroundColor: kColorLightPink,
      headerBackgroundColorOpened: kColorLightBlue,
      children: lis,
    );

    setState(() {
      showSpinner = false;
    });
    return acc;
  }
}
