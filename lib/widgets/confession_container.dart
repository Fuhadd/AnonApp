import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/custom_colors.dart';
import '../utils/spacers.dart';

class ConfessionContainer extends StatelessWidget {
  const ConfessionContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: CustomColors.mainBlueColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20),
              child: Container(
                height: 23,
                width: 55,
                decoration: BoxDecoration(
                    color: CustomColors.whiteColor,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text(
                    "3 Feb",
                    style: TextStyle(
                        color: CustomColors.greyBgColor, fontSize: 13),
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "05 Mins Read",
                  style:
                      TextStyle(color: CustomColors.greyBgColor, fontSize: 13),
                ),
                verticalSpacer(10),
                Column(
                  children: const [
                    SizedBox(
                      child: Text(
                        "Make design systems people want to use ",
                        style: TextStyle(
                            color: CustomColors.blackBgColor, fontSize: 17),
                      ),
                    ),
                  ],
                ),
                verticalSpacer(15),
                Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "22.8K",
                            style: TextStyle(
                                color: CustomColors.greyBgColor, fontSize: 13),
                          ),
                          horizontalSpacer(8),
                          const FaIcon(
                            FontAwesomeIcons.bookOpenReader,
                            size: 14,
                            color: CustomColors.greyBgColor,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "8K",
                            style: TextStyle(
                                color: CustomColors.greyBgColor, fontSize: 13),
                          ),
                          horizontalSpacer(8),
                          const FaIcon(
                            FontAwesomeIcons.comments,
                            size: 14,
                            color: CustomColors.greyBgColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
