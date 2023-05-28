import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Constants/custom_colors.dart';
import '../utils/spacers.dart';

class SupportContainer extends StatelessWidget {
  const SupportContainer({
    super.key,
    required this.containerIcon,
    required this.title,
    required this.subTitle,
    required this.iconBgColor,
  });
  final Color iconBgColor;
  final Widget containerIcon;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.2,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                      // margin:
                      //     const EdgeInsets.only(top: 5, bottom: 5),
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: iconBgColor),
                      child: Center(
                        child: containerIcon,
                        // FaIcon(
                        //   FontAwesomeIcons.message,
                        //   size: 20,
                        // ),
                      )),
                ),
                horizontalSpacer(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      // "Chat",
                      style: TextStyle(
                          fontSize: 18,
                          color: CustomColors.blackColor.withOpacity(0.8),
                          fontWeight: FontWeight.w600),
                    ),
                    verticalSpacer(5),
                    Text(
                      subTitle,
                      // "Connect 1-1 and group chat",
                      style: TextStyle(
                          fontSize: 13,
                          color: CustomColors.blackColor.withOpacity(0.6),
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
            SvgPicture.asset("assets/icons/arrow_forward.svg"),
          ],
        ),
      ),
    );
  }
}
