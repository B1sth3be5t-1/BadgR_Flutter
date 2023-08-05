import 'package:accordion/accordion.dart';
import 'package:badgr/classes/constants.dart';
import 'package:flutter/material.dart';
import 'package:badgr/classes/widgets/custom_input.dart';
import 'package:badgr/classes/widgets/custom_header.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            CustomHeader('Search', kColorDarkBlue),
            Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: 5,
                  child: CustomFormField(
                      controller: _tec,
                      hintText: 'Enter a full or partial badge name',
                      obscureText: false),
                ),
                Expanded(
                  flex: 1,
                  child: Material(
                    color: kColorDarkBlue,
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: TextButton(
                      onPressed: () {
                        buildAccordion();
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
            buildAccordion(),
          ],
        ),
      ),
    );
  }

  Accordion buildAccordion() {
    List<AccordionSection> lis = [];
    //todo get db stuff here

    Accordion acc = Accordion(
      maxOpenSections: 20,
      headerBackgroundColor: kColorLightPink,
      headerBackgroundColorOpened: kColorLightBlue,
      children: lis,
    );

    return acc;
  }
}
