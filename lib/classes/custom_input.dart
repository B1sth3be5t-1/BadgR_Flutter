import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:badgr/classes/constants.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    Key? key,
    required this.hintText,
    this.errorText,
    required this.obscureText,
    this.inputFormatters,
    this.onChanged,
    this.validator,
  }) : super(key: key);
  final String hintText;
  final String? errorText;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        inputFormatters: inputFormatters,
        validator: validator,
        onChanged: onChanged,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          errorText: errorText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          errorStyle: const TextStyle(
            color: kColorDarkPink,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: kBorder,
          enabledBorder: kBorderEnabled,
          focusedBorder: kBorderFocused,
        ),
        cursorColor: kColorBlue,
        textAlign: TextAlign.center,
      ),
    );
  }
}

extension ExtString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp = RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');
    return passwordRegExp.hasMatch(this);
  }
}
