import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../../core/utils/validators/my_validator.dart';

class DefaultCustomFormField extends StatelessWidget {
  const DefaultCustomFormField({
    super.key,
    required this.textfieldcontroller,
    this.focusnode,
    this.focusnodeto,
    required this.inputaction,
    required this.inputtype,
    required this.hint,
    this.icon = IconlyLight.message,
    this.maxlines = 1,
    this.maxLength,
    this.minlines = 1,
    required this.massege,
    this.formatter,
    this.textCaptilize = TextCapitalization.none,
  });

  final TextEditingController textfieldcontroller;
  final FocusNode? focusnode;
  final FocusNode? focusnodeto;
  final TextInputAction inputaction;
  final TextInputType inputtype;
  final String hint;
  final IconData icon;
  final int? maxLength;
  final int minlines;
  final int maxlines;
  final String massege;
  final TextCapitalization textCaptilize;
  final List<TextInputFormatter>? formatter;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textfieldcontroller,
      focusNode: focusnode,
      textInputAction: inputaction,
      keyboardType: inputtype,
      minLines: minlines,
      maxLines: maxlines,
      maxLength: maxLength,
      inputFormatters: formatter,
      textCapitalization: textCaptilize,
      decoration: InputDecoration(hintText: hint),
      validator: (value) {
        return MyValidators.uploadProdTexts(
            value: value, toBeReturnedString: massege);
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(focusnodeto);
      },
    );
  }
}
