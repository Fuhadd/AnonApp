import 'package:anon/models/app_user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../Constants/custom_colors.dart';
import '../../data/local_cache/local_cache.dart';
import '../../locator.dart';
import '../../utils/loader.dart';
import '../../utils/spacers.dart';
import '../../widgets/custom_noborder_textfield.dart';
import 'confession_view_model.dart';

class ConfessionSendScreen extends StatefulHookConsumerWidget {
  const ConfessionSendScreen(
      {super.key,
      this.destinationId,
      this.destinationImage,
      this.destinationName});
  final String? destinationId;
  final String? destinationName;
  final String? destinationImage;

  @override
  ConsumerState<ConfessionSendScreen> createState() =>
      _ConfessionSendScreenState();
}

class _ConfessionSendScreenState extends ConsumerState<ConfessionSendScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  ConfessorsModel? selectedConfessor;

  @override
  Widget build(BuildContext context) {
    final userData = locator<LocalCache>().getUserData();
    print(userData.pastConfessor.isEmpty);
    final confessionVM = ref.watch(confessionProvider);
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
                  verticalSpacer(40),
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
                    '@${widget.destinationName ?? "someone"}',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        color: CustomColors.blackBgColor.withOpacity(0.7)),
                  ),
                  verticalSpacer(15),
                  userData.pastConfessor.isNotEmpty ||
                          widget.destinationId != null
                      ? Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                              color: CustomColors.whiteColor,
                              // border: Border.all(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<ConfessorsModel>(
                                  hint: const Text(
                                    "Recenty sent to ..",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  isExpanded: true,
                                  elevation: 0,
                                  value: selectedConfessor,
                                  items: userData.pastConfessor
                                      .map((pastConfessors) {
                                    return DropdownMenuItem(
                                      value: pastConfessors,
                                      child: Text(pastConfessors.name),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    selectedConfessor = value;
                                  },
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  // verticalSpacer(60),cbs
                  // customTextField(
                  //   'userName',
                  //   Icons.person,
                  //   null,
                  //   'User Name',
                  //   validator: FormBuilderValidators.compose(
                  //     [
                  //       FormBuilderValidators.email(
                  //           errorText: 'Provided email not valid '),
                  //       FormBuilderValidators.required(
                  //           errorText: 'Email field cannot be empty '),
                  //     ],
                  //   ),
                  // ),
                  verticalSpacer(30),
                  customNoBorderTextField(
                    'message',
                    Icons.mail,
                    null,
                    'Leave A Message',
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.minLength(4,
                            errorText:
                                'A valid user name should be greater than 4 characters '),
                      ],
                    ),
                  ),
                  verticalSpacer(30),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          bool? validate = _formKey.currentState?.validate();
                          // print(validate);
                          if (validate == true &&
                              (widget.destinationName != null ||
                                  selectedConfessor != null)) {
                            _formKey.currentState?.save();

                            var message = _formKey
                                .currentState?.fields['message']?.value
                                .toString()
                                .trim();
                            confessionVM.sendConfession(
                                message: message!,
                                destinationName: widget.destinationName ??
                                    selectedConfessor!.name,
                                destinationId: widget.destinationId ??
                                    selectedConfessor!.id,
                                destinationImage: widget.destinationImage ?? "",
                                formKey: _formKey,
                                ref: ref);
                          }
                        },
                        child: ref.watch(sendAnotherMessage) == false
                            ? Container(
                                width: 80,
                                height: 55,
                                decoration: BoxDecoration(
                                    color: CustomColors.mainBlueColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: confessionVM.isLoading
                                    ? const Center(child: loader)
                                    : const Icon(
                                        Icons.arrow_forward,
                                        size: 30,
                                      ),
                              )
                            : Container(
                                width: 200,
                                height: 45,
                                decoration: BoxDecoration(
                                    color: CustomColors.mainBlueColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: confessionVM.isLoading
                                    ? const Center(child: loader)
                                    : const Center(
                                        child: Text(
                                          'Send Another Message',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                          // size: 30,
                                        ),
                                      ),
                              ),
                      )
                    ],
                  )
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
