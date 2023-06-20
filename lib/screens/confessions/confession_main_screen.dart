import 'package:anon/utils/spacers.dart';
import 'package:flutter/material.dart';

import '../../Constants/custom_colors.dart';
import '../../constants/custom_string.dart';
import '../../widgets/primary_button.dart';

class ConfessionMainScreen extends StatefulWidget {
  const ConfessionMainScreen({super.key});

  @override
  State<ConfessionMainScreen> createState() => _ConfessionMainScreenState();
}

class _ConfessionMainScreenState extends State<ConfessionMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: double.infinity,
            decoration: const BoxDecoration(
              color: CustomColors.whiteBgColor,
            ),
            child: RefreshIndicator(
              color: CustomColors.mainBlueColor,
              backgroundColor: CustomColors.whiteColor,
              onRefresh: () async {
                // return await refreshPage();
              },
              child: Column(
                children: [
                  Column(
                    children: [
                      verticalSpacer(20),
                      const Text(
                        "Refer and Earn",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: CustomColors.mainBlueColor,
                        ),
                      ),
                      verticalSpacer(8),

                      const Text(
                        ConstantString.referAndEarn,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 1.4,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: CustomColors.mainBlueColor),
                      ),

                      verticalSpacer(40),
                      Image.asset(
                        "assets/images/anon_icon.png",
                        height: 100,
                        fit: BoxFit.cover,
                      ),

                      verticalSpacer(60),
                      // const Text(

                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //       fontSize: 24, fontWeight: FontWeight.w900,color: C),
                      // ),

                      // const Text(

                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //       height: 1.4,
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.w400),
                      // ),
                    ],
                  ),
                  2 != 1
                      ? Column(
                          children: [
                            Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                height: 155,
                                decoration: BoxDecoration(
                                  color: CustomColors.mainBlueColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: PrimaryButton(
                                    isLoading: false,
                                    titleBold: true,
                                    color: CustomColors.whiteColor,
                                    textColor: CustomColors.mainBlueColor,
                                    borderColor: CustomColors.greyTextColor,
                                    text: 'Get my code',
                                    width: 186,
                                    onPressed: () async {
                                      // await referralVM.createReferralCode();
                                    },
                                  ),
                                )),
                          ],
                        )
                      : Column(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              height: 177,
                              decoration: BoxDecoration(
                                color: CustomColors.mainBlueColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 220,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        color: CustomColors.mainBlueColor,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          " data.code",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 24,
                                            color: CustomColors.whiteColor,
                                            letterSpacing: 6,
                                            // fontFamily: fontFamily,
                                          ),
                                        ),
                                      ),
                                    ),
                                    verticalSpacer(15),
                                    const Text(
                                      ConstantString.referralCodeShare,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          height: 1.4,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: CustomColors.mainBlueColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            verticalSpacer(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: CustomColors.greyBgColor,
                                      ),
                                      child: const Icon(
                                        Icons.share,
                                        color: CustomColors.blackBgColor,
                                      ),
                                    ),
                                    verticalSpacer(8),
                                    const Text(
                                      'Share',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          height: 1.4,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: CustomColors.greyBgColor),
                                    ),
                                  ],
                                ),
                                verticalSpacer(30),
                                Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: CustomColors.greyBgColor,
                                      ),
                                      child: const Icon(
                                        Icons.copy,
                                        color: CustomColors.blackBgColor,
                                      ),
                                    ),
                                    verticalSpacer(8),
                                    const Text(
                                      'Copy',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        height: 1.4,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: CustomColors.mainBlueColor,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                  verticalSpacer(8),
                ],
              ),

              // SingleChildScrollView(
              //     physics: const BouncingScrollPhysics(
              //         parent: AlwaysScrollableScrollPhysics()),
              //     child:

              //     Column(children: [
              //       Container(
              //         height: MediaQuery.of(context).size.height,
              //         decoration: const BoxDecoration(
              //           color: CustomColors.whiteColor,
              //         ),
              //         child: Column(
              //           children: [
              //             Gap(20.h),
              //             Text(
              //               "Refer and Earn",
              //               textAlign: TextAlign.center,
              //               style: CustomStyle.textStyleBold4.copyWith(
              //                   color: CustomColors.blackBackgroundColor),
              //             ),
              //             Gap(8.0.h),
              //             Text(
              //               ConstantString.referAndEarn,
              //               textAlign: TextAlign.center,
              //               style: CustomStyle.textStyleBody1.copyWith(
              //                   fontSize: 16.sp,
              //                   color: CustomColors.blackBackgroundColor
              //                       .withOpacity(0.5)),
              //             ),
              //             const Gap(100),

              //             const SizedBox(
              //               height: 10,
              //             )
              //           ],
              //         ),
              //       ),
              //     ]))));
            )),
      ),
    );
  }
}
