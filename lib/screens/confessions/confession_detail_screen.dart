// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:anon/constants/custom_colors.dart';
import 'package:anon/utils/spacers.dart';

class ConfessionDetailScreen extends StatelessWidget {
  final String title;
  final String content;
  const ConfessionDetailScreen({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteBgColor,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpacer(25),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.canPop(context)
                        ? Navigator.of(context).pop()
                        : null;
                  },
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // color: CustomColors.whiteColor,
                      borderRadius: BorderRadius.circular(25),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          horizontalSpacer(5),
                          const Icon(
                            Icons.arrow_back,
                            size: 13,
                          ),
                          horizontalSpacer(8),
                          Text(
                            "Confessions  ...",
                            style: TextStyle(
                                fontSize: 12,
                                // fontWeight: FontWeight.w400,
                                color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // color: CustomColors.whiteColor,
                    borderRadius: BorderRadius.circular(25),
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
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        horizontalSpacer(8),
                        Text(
                          "Aa",
                          style: TextStyle(
                              fontSize: 12,
                              // fontWeight: FontWeight.w400,
                              color: Colors.grey.shade500),
                        ),
                        horizontalSpacer(15),
                        const Icon(
                          Icons.headphones,
                          size: 13,
                        ),
                        horizontalSpacer(15),
                        const Icon(
                          FontAwesomeIcons.ellipsisVertical,
                          size: 13,
                        ),
                        horizontalSpacer(8),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          verticalSpacer(50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: CustomColors.blackBgColor,
                  fontSize: 25),
            ),
          ),
          verticalSpacer(30),
          Expanded(
              child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  content,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    height: 1.3,
                    color: CustomColors.greyBgColor.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          )),
          verticalSpacer(20),
          Container(
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              // color: CustomColors.whiteColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(45),
                topRight: Radius.circular(45),
              ),
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
              padding: const EdgeInsets.symmetric(horizontal: 55.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // const Icon(
                  //   FontAwesomeIcons.bookmark,
                  //   size: 22,
                  //   color: Colors.grey,
                  // ),
                  Icon(
                    FontAwesomeIcons.chevronLeft,
                    size: 20,
                    color: CustomColors.mainBlueColor.withOpacity(0.6),
                  ),
                  Icon(
                    FontAwesomeIcons.reply,
                    size: 20,
                    color: CustomColors.mainBlueColor.withOpacity(0.6),
                  ),
                  // horizontalSpacer(40),
                  Icon(
                    FontAwesomeIcons.camera,
                    size: 22,
                    color: CustomColors.mainBlueColor.withOpacity(0.6),
                  ),
                  // horizontalSpacer(40),
                  Icon(
                    FontAwesomeIcons.checkDouble,
                    size: 22,
                    color: CustomColors.mainBlueColor.withOpacity(0.6),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
