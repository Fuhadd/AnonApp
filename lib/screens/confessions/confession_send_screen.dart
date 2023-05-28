import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../Constants/custom_colors.dart';
import '../../data/local_cache/local_cache.dart';
import '../../locator.dart';
import '../../utils/spacers.dart';
import '../../widgets/custom_noborder_textfield.dart';
import '../../widgets/custom_text_field.dart';

class ConfessionSendScreen extends StatefulWidget {
  const ConfessionSendScreen({super.key});

  @override
  State<ConfessionSendScreen> createState() => _ConfessionSendScreenState();
}

class _ConfessionSendScreenState extends State<ConfessionSendScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final userData = locator<LocalCache>().getUserData();
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0, top: 10, bottom: 10),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CustomColors.blackBgColor.withOpacity(0.2),
                    image: DecorationImage(
                        image: NetworkImage(userData.avatarUrl))),
                // child: const Icon(Icons.person_2_outlined),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Text(
                  //   "Welcome Back,",
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.w300,
                  //       fontSize: 30,
                  //       color: CustomColors.blackBgColor),
                  // ),
                  const Text(
                    "Say Something About",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                        color: CustomColors.blackBgColor),
                  ),
                  Text(
                    "@elvissssss",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        color: CustomColors.blackBgColor.withOpacity(0.7)),
                  ),
                  verticalSpacer(60),
                  customTextField(
                    'userName',
                    Icons.person,
                    null,
                    'User Name',
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
                  customNoBorderTextField(
                    'email',
                    Icons.mail,
                    null,
                    'Leave A Message',
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
                  // customTextField(
                  //   'password',
                  //   Icons.vpn_key,
                  //   Icons.remove_red_eye_outlined,
                  //   'Password',
                  //   // obscureText: passwordObscured,
                  //   // onSuffixTap: () {
                  //   //   setState(() {
                  //   //     passwordObscured = !passwordObscured;
                  //   //   });
                  //   // },
                  //   onChanged: (value) {
                  //     // setState(() {
                  //     //   password = value!;
                  //     //   print(password);
                  //     // });
                  //   },
                  //   validator: FormBuilderValidators.compose([
                  //     FormBuilderValidators.minLength(6,
                  //         errorText:
                  //             'Good passwords are greater than 6 characters'),
                  //     FormBuilderValidators.required(
                  //         errorText: 'Password field cannot be empty '),
                  //   ]),
                  // ),
                ],
              ),
            ),
          ),
        ));
  }
}
