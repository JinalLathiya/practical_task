import 'package:flutter/material.dart';

class TimeInputField extends StatelessWidget {
  const TimeInputField({
    super.key,
    required this.controller,
    this.focusNode,
    this.autofocus = false,
    required this.hintText,
    required this.suffixWidget,
    required this.validator,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool autofocus;
  final String hintText;
  final Widget suffixWidget;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      autofocus: autofocus,
      readOnly: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixWidget,
      ),
    );
  }
}
