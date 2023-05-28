import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../constants/custom_colors.dart';

FormBuilderTextField customNoBorderTextField(
    String name, IconData prefixIcon, IconData? suffixIcon, String labelText,
    {String? hintText,
    Widget? prefix,
    String? initialValue,
    bool isHint = false,
    bool obscureText = false,
    String? helperText,
    String? Function(String?)? validator,
    void Function()? onSuffixTap,
    void Function(String?)? onChanged}) {
  return FormBuilderTextField(
    initialValue: initialValue,
    cursorColor: CustomColors.mainBlueColor,
    name: name,
    minLines: 5,
    maxLines: 100,
    maxLength: 2000,
    obscureText: obscureText,
    validator: validator,
    onChanged: onChanged,
    decoration: customFormDecoration(
        hintText, labelText, prefixIcon, suffixIcon,
        prefix: prefix, helperText: helperText, onSuffixTap: onSuffixTap),
  );
}

InputDecoration customFormDecoration(String? hintText, String labelText,
    IconData? prefixIcon, IconData? suffixIcon,
    {String? helperText,
    Widget? prefix,
    bool isHint = false,
    void Function()? onSuffixTap}) {
  return InputDecoration(
      hintText: isHint ? '' : hintText,
      prefix: prefix,
      helperText: helperText,
      contentPadding: const EdgeInsets.only(top: 12.0),
      helperMaxLines: 7,
      helperStyle: const TextStyle(fontSize: 13),
      floatingLabelStyle:
          const TextStyle(color: CustomColors.mainBlueColor, fontSize: 18),
      floatingLabelAlignment: FloatingLabelAlignment.start,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      fillColor: CustomColors.mainBlueColor,
      border: InputBorder.none,
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: CustomColors.mainBlueColor)),
      labelText: labelText,
      labelStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: CustomColors.greyBgColor));
}
