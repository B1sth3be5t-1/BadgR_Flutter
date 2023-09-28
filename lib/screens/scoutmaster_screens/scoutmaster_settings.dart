import 'package:accordion/accordion.dart';
import 'package:badgr/classes/widgets/custom_alert.dart';
import 'package:flutter/material.dart';
import 'package:badgr/classes/widgets/settings.dart';
import 'package:badgr/classes/widgets/custom_input.dart';
import 'package:flutter/services.dart';

import '../../classes/firebase_runner.dart';
import 'package:badgr/classes/colors_and_themes/themes.dart';

class ScoutmasterSettings extends StatefulWidget {
  const ScoutmasterSettings({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScoutmasterSettingsState createState() => _ScoutmasterSettingsState();
}

class _ScoutmasterSettingsState extends State<ScoutmasterSettings> {
  static Map<String, Widget> map = Map();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller1 = new TextEditingController();
  final TextEditingController _controller2 = new TextEditingController();
  final TextEditingController _controller3 = new TextEditingController();
  final TextEditingController _controller4 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _style = Theme.of(context).primaryTextTheme.displaySmall;

    map['Account'] = setForm(_style);

    return SettingsWidget(
      map: map,
      headerStyle: _style,
    );
  }

  Form setForm(TextStyle? _headerStyle) {
    return Form(
      key: _formKey,
      child: Accordion(
        maxOpenSections: 5,
        headerBackgroundColor: AccordionTheme.headerBackgroundColor,
        headerBackgroundColorOpened: AccordionTheme.headerBackgroundColorOpened,
        contentBackgroundColor: AccordionTheme.contentBackgroundColor,
        contentBorderColor: AccordionTheme.contentBorderColor,
        children: [
          AccordionSection(
            isOpen: true,
            header: Text(
              'Edit first name',
              style: Theme.of(context).primaryTextTheme.displaySmall,
            ),
            onCloseSection: () {
              _controller1.clear();
            },
            content: CustomFormField(
              controller: _controller1,
              hintText: 'Enter First Name',
              labelText: 'First Name',
              obscureText: false,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r"[a-zA-Z]+|\s"),
                )
              ],
              validator: (val) {
                if (val == '') return null;
                if (!val!.isValidName) return 'Enter valid first name';
                return null;
              },
            ),
          ),
          AccordionSection(
            header: Text(
              'Edit last name',
              style: _headerStyle,
            ),
            onCloseSection: () {
              _controller2.clear();
            },
            content: CustomFormField(
              controller: _controller2,
              hintText: 'Enter Last Name',
              labelText: 'Last Name',
              obscureText: false,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r"[a-zA-Z]+|\s"),
                )
              ],
              validator: (val) {
                if (val == '') return null;
                if (!val!.isValidName) return 'Enter valid last name';
                return null;
              },
            ),
          ),
          AccordionSection(
            header: Text(
              'Update age',
              style: _headerStyle,
            ),
            onCloseSection: () {
              _controller3.clear();
            },
            content: CustomFormField(
              controller: _controller3,
              hintText: 'Enter Age',
              labelText: 'Age',
              obscureText: false,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r"[0-9]"),
                )
              ],
              validator: (val) {
                if (val == '') return null;
                if (int.parse(val!) >= 100 || int.parse(val) <= 5)
                  return 'Enter valid age';
                return null;
              },
            ),
          ),
          AccordionSection(
            header: Text(
              'Change troop',
              style: _headerStyle,
            ),
            onCloseSection: () {
              _controller4.clear();
            },
            content: CustomFormField(
              controller: _controller4,
              labelText: 'Troop',
              hintText: 'Enter Troop num',
              obscureText: false,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r"[0-9]"),
                )
              ],
              validator: (val) {
                if (val == '') return null;
                if (int.parse(val!) <= 0) return 'Enter valid troop';
                return null;
              },
            ),
          ),
          AccordionSection(
            isOpen: true,
            header: Text(
              'Buttons',
              style: _headerStyle,
            ),
            content: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: 4,
                  child: TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Map<String, String> m = Map();
                        if (_controller1.text != '')
                          m['fname'] = _controller1.text;
                        if (_controller2.text != '')
                          m['lname'] = _controller2.text;
                        if (_controller3.text != '')
                          m['age'] = _controller3.text;
                        if (_controller4.text != '')
                          m['troop'] = _controller4.text;
                        if (!m.isEmpty) {
                          bool cont = true;
                          await showDiag(
                              'Confirm Submit',
                              'Are you sure you want to submit information?',
                              context,
                              ['Cancel', 'Ok']).then((value) {
                            if (value == null) return;
                            if (value == 'Cancel') cont = false;
                          });
                          if (!cont) return;
                          try {
                            String res = await FirebaseRunner.updateAccount(m);
                            if (res == 'Error') throw Exception('Error!');
                            showDiag('Update Success',
                                'Your updates have been successful', context, [
                              'Ok'
                            ]).then((value) => FirebaseRunner.sendUser(
                                context, FirebaseRunner.getScoutmaster()!.email,
                                b: true));
                          } on Exception {
                            showDiag('Update Failure',
                                'Your updates have failed', context, ['Ok']);
                          }
                        } else {
                          showDiag(
                              'Update Failure',
                              'Please enter at least one value',
                              context,
                              ['Ok']);
                        }
                        _controller1.clear();
                        _controller2.clear();
                        _controller3.clear();
                        _controller4.clear();
                      }
                    },
                    child: Text(
                      'Submit',
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: 5,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Material(
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: TextButton(
                      onPressed: () {
                        _controller1.clear();
                        _controller2.clear();
                        _controller3.clear();
                        _controller4.clear();
                      },
                      child: Text(
                        'Clear',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
