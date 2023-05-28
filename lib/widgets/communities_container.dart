import 'package:flutter/material.dart';

import '../Constants/custom_colors.dart';
import '../utils/spacers.dart';

class CommunitiesContainer extends StatelessWidget {
  const CommunitiesContainer({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      height: 250,
      decoration: BoxDecoration(
        color: CustomColors.whiteColor,
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Image(
                  image: AssetImage("assets/images/relationship_nobg2.png"),
                  fit: BoxFit.cover),
            ),
            verticalSpacer(20),
            Text(
              title,
              style: const TextStyle(
                  color: CustomColors.blackBgColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w800),
            ),
            verticalSpacer(6),
            Text(
              "124 Members",
              style: TextStyle(
                  color: CustomColors.greyBgColor.withOpacity(0.7),
                  fontSize: 13),
            ),
            verticalSpacer(25),
            Row(
              children: [
                const Text(
                  "Join group",
                  style: TextStyle(
                    color: CustomColors.mainBlueColor,
                  ),
                ),
                horizontalSpacer(4),
                const Icon(
                  Icons.arrow_forward,
                  color: CustomColors.mainBlueColor,
                ),
              ],
            ),
            verticalSpacer(25),
          ],
        ),
      ),
    ));
  }
}
