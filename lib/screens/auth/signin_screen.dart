import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../constants/custom_colors.dart';
import '../../utils/spacers.dart';
import '../../widgets/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key, required this.formkey});
  final GlobalKey<FormBuilderState> formkey;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool passwordObscured = true;
  void _signIn() {
    print("Signed In");
    // signIn();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: widget.formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Welcome Back,",
            style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 30,
                color: CustomColors.blackBgColor),
          ),
          const Text(
            "Rebecca",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30,
                color: CustomColors.blackBgColor),
          ),
          verticalSpacer(60),
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
            obscureText: passwordObscured,
            onSuffixTap: () {
              setState(() {
                passwordObscured = !passwordObscured;
              });
            },
            onChanged: (value) {
              // setState(() {
              //   password = value!;
              //   print(password);
              // });
            },
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.minLength(6,
                  errorText: 'Good passwords are greater than 6 characters'),
              FormBuilderValidators.required(
                  errorText: 'Password field cannot be empty '),
            ]),
          ),
        ],
      ),
    );
  }
}
