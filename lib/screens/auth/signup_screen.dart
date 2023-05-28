import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../constants/custom_colors.dart';
import '../../utils/spacers.dart';
import '../../widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
    required this.formkey,
  });
  final GlobalKey<FormBuilderState> formkey;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  File? image;
  String password = "";
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: widget.formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hello,",
            style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 30,
                color: CustomColors.blackBgColor),
          ),
          verticalSpacer(5),
          const Text(
            "Anonymous",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30,
                color: CustomColors.blackBgColor),
          ),
          verticalSpacer(50),
          customTextField(
            'name',
            Icons.person,
            null,
            'User Name',
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.minLength(4,
                    errorText:
                        'A valid user name should be greater than 4 characters '),
              ],
            ),
          ),
          verticalSpacer(30),
          customTextField(
            'email',
            Icons.mail,
            null,
            'Email',
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.email(
                    errorText: 'Provided email not valid '),
                FormBuilderValidators.required(
                    errorText: 'Email field cannot be empty '),
              ],
            ),
          ),
          verticalSpacer(30),
          customTextField(
            'password',
            Icons.vpn_key,
            Icons.remove_red_eye_outlined,
            'Password',
            obscureText: obscurePassword,
            onSuffixTap: () {
              setState(() {
                obscurePassword = !obscurePassword;
              });
            },
            onChanged: (value) {
              setState(() {
                password = value!;
                print(password);
              });
            },
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.minLength(6,
                  errorText: 'Good passwords are greater than 6 characters'),
              FormBuilderValidators.required(
                  errorText: 'Password field cannot be empty '),
            ]),
          ),
          verticalSpacer(30),
          customTextField(
            'confirm_password',
            Icons.vpn_key,
            Icons.remove_red_eye_outlined,
            'Password Again',
            obscureText: obscureConfirmPassword,
            onSuffixTap: () {
              setState(() {
                obscureConfirmPassword = !obscureConfirmPassword;
              });
            },
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.equal(password,
                  errorText: 'Passwords do not match!  '),
            ]),
          ),
        ],
      ),
    );
  }
}
