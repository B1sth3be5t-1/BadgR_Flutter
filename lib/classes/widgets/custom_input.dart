import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:badgr/classes/colors_and_themes/themes.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField(
      {Key? key,
      required this.hintText,
      this.errorText,
      required this.obscureText,
      this.controller,
      this.icon,
      required this.labelText,
      this.inputFormatters,
      this.onChanged,
      this.validator,
      required this.isLast,
      this.focusNode})
      : super(key: key);

  final String hintText;
  final String? errorText;
  late final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Icon? icon;
  final String? labelText;
  final bool isLast;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        scrollPadding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        controller: controller,
        textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
        inputFormatters: inputFormatters,
        validator: validator,
        onChanged: onChanged,
        obscureText: obscureText,
        focusNode: focusNode,
        style: isLight()
            ? kThemeLight.primaryTextTheme.labelMedium
            : kThemeDark.primaryTextTheme.labelMedium,
        decoration: InputDecoration(
          icon: icon,
          hintText: hintText,
          labelText: labelText,
          labelStyle: TextStyle(
              color: Theme.of(context).primaryTextTheme.labelSmall?.color),
          errorText: errorText,
          hintStyle: TextStyle(
              color: Theme.of(context).primaryTextTheme.labelSmall?.color),
        ),
        cursorColor: Theme.of(context).colorScheme.onPrimaryContainer,
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

  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
