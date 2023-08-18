import 'package:accordion/accordion.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:badgr/classes/constants.dart';
import 'package:badgr/classes/widgets/custom_alert.dart';
import 'package:flutter/material.dart';
import 'package:badgr/classes/widgets/settings.dart';
import 'package:badgr/classes/widgets/custom_input.dart';
import 'package:flutter/services.dart';

import '../../classes/firebase_runner.dart';
import 'package:badgr/classes/themes.dart';

class ScoutSettings extends StatefulWidget {
  const ScoutSettings({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScoutSettingsState createState() => _ScoutSettingsState();
}

class _ScoutSettingsState extends State<ScoutSettings> {
  static Map<String, Widget> map = Map();
  final _headerStyle = TextStyle(
      color: isLight() ? kColorDarkBlue : kColorDarkBlue,
      fontSize: 15,
      fontWeight: FontWeight.bold);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller1 = new TextEditingController();
  final TextEditingController _controller2 = new TextEditingController();
  final TextEditingController _controller3 = new TextEditingController();
  final TextEditingController _controller4 = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('rebuilt');
    map['Account'] = setForm();
    map['Personalization'] = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextButton(
        onPressed: () {
          switchTheme(context);
          setState(() {
            map['Account'] = setForm();
          });
        },
        child: Text('Switch app appearance'),
      ),
    );

    return SettingsWidget(
      map: map,
      headerStyle: _headerStyle,
    );
  }

  Form setForm() {
    bool l = isLight();
    print(l);
    return Form(
      key: _formKey,
      child: Accordion(
        maxOpenSections: 5,
        headerBackgroundColor: l ? kColorLightPink : kColorPink,
        headerBackgroundColorOpened: l ? kColorBlue : kColorLightPink,
        contentBackgroundColor: l
            ? kThemeLight.scaffoldBackgroundColor
            : kThemeDark.scaffoldBackgroundColor,
        contentBorderColor: l ? kColorDarkBlue : kColorLightPink,
        children: [
          AccordionSection(
            isOpen: true,
            header: Text(
              'Edit first name',
              style: _headerStyle,
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
                                  ['Cancel', 'Ok'],
                                  kColorXLightBlue,
                                  kColorDarkBlue)
                              .then((value) {
                            if (value == null) return;
                            if (value == 'Cancel') cont = false;
                          });
                          if (!cont) return;
                          try {
                            String res = await FirebaseRunner.updateAccount(m);
                            if (res == 'Error') throw Exception('Error!');
                            showDiag(
                                'Update Success',
                                'Your updates have been successful',
                                context,
                                ['Ok'],
                                kColorXLightBlue,
                                kColorDarkBlue);
                          } on Exception {
                            showDiag(
                                'Update Failure',
                                'Your updates have failed',
                                context,
                                ['Ok'],
                                kColorXLightBlue,
                                kColorDarkBlue);
                          }
                        } else {
                          showDiag(
                              'Update Failure',
                              'Please enter at least one value',
                              context,
                              ['Ok'],
                              kColorXLightBlue,
                              kColorDarkBlue);
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
