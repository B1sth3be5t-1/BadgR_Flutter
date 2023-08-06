import 'package:accordion/accordion.dart';
import 'package:badgr/classes/constants.dart';
import 'package:flutter/material.dart';
import 'package:badgr/classes/widgets/settings.dart';
import 'package:badgr/classes/widgets/custom_input.dart';
import 'package:flutter/services.dart';

import '../../classes/firebase_runner.dart';

class ScoutSettings extends StatefulWidget {
  const ScoutSettings({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScoutSettingsState createState() => _ScoutSettingsState();
}

class _ScoutSettingsState extends State<ScoutSettings> {
  static Map<String, Widget> map = Map();
  final _headerStyle = const TextStyle(
      color: kColorDarkBlue, fontSize: 15, fontWeight: FontWeight.bold);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller1 = new TextEditingController();
  final TextEditingController _controller2 = new TextEditingController();
  final TextEditingController _controller3 = new TextEditingController();
  final TextEditingController _controller4 = new TextEditingController();

  @override
  void initState() {
    super.initState();
    map['Account'] = Form(
      key: _formKey,
      child: Accordion(
        maxOpenSections: 5,
        headerBackgroundColor: kColorLightPink,
        headerBackgroundColorOpened: kColorLightBlue,
        children: [
          AccordionSection(
            header: Text(
              'Edit first name',
              style: _headerStyle,
            ),
            onCloseSection: () {
              _controller1.clear();
            },
            content: CustomFormField(
              controller: _controller1,
              hintText: 'First Name',
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
              hintText: 'Last Name',
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
              hintText: 'Age',
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
              hintText: 'Troop',
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
                  child: Material(
                    color: kColorDarkBlue,
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: TextButton(
                      onPressed: () {
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
                          try {
                            FirebaseRunner.updateAccount(m);
                          } catch (e) {
                            print(e);
                          }
                        }
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: 5,
                  ),
                ),
                Expanded(
                  child: Material(
                    color: kColorDarkBlue,
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
                        style: TextStyle(color: Colors.white),
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
    map['Personalization'] = Text('Work in Progress');
  }

  @override
  Widget build(BuildContext context) {
    return SettingsWidget(
      BGcolor: kColorLightPink,
      textColor: kColorXDarkBlue,
      map: map,
      headerStyle: _headerStyle,
    );
  }
}
