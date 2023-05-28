import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/custom_colors.dart';
import '../../utils/spacers.dart';

class ThirdOnboardingPage extends StatelessWidget {
  static const routeName = '/thirdOnboardingScreen';
  const ThirdOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          'assets/icons/onboarding_anonymous.svg',
          height: 150,
          // color: CustomColors.navBarGrey
        ),
        verticalSpacer(40),
        const Text(
          "Get Started",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: CustomColors.greyTextColor,
              fontSize: 20),
        ),
        verticalSpacer(20),
        const Text(
          "Read, Write and Chat Anonymously\nTry now",
          // "Publish Your \nPassion in Own Way \nIt's Free",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              color: CustomColors.blackBgColor,
              fontSize: 30),
        ),
      ],
    );
  }
}
