import 'package:flutter/material.dart';

import '../constants/custom_colors.dart';
import '../utils/spacers.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer({super.key, required this.isGroup});
  final bool isGroup;

  @override
  Widget build(BuildContext context) {
    String name = "Babz";
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 0),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: CustomColors.mainBlueColor),
                child: const Icon(Icons.person_2_outlined),
              ),
            ),
            horizontalSpacer(15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Trish",
                    style: TextStyle(
                        color: CustomColors.blackColor.withOpacity(0.9),
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  verticalSpacer(5),
                  isGroup
                      ? Row(
                          children: [
                            Text(
                              "$name: ",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(
                                  color:
                                      CustomColors.blackColor.withOpacity(0.7),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13),
                            ),
                            Text(
                              "Going there today is a tad bit risky okay?",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(
                                  color:
                                      CustomColors.blackColor.withOpacity(0.4),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13),
                            ),
                          ],
                        )
                      : Text(
                          "Going there today is a tad bit risky okay?",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: TextStyle(
                              color: CustomColors.blackColor.withOpacity(0.4),
                              fontWeight: FontWeight.w500,
                              fontSize: 13),
                        ),
                ],
              ),
            )
          ],
        ),
        verticalSpacer(25),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Divider(
            color: CustomColors.blackBgColor.withOpacity(0.6),
          ),
        ),
        verticalSpacer(25),
      ],
    );
  }
}
