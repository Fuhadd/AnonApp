import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/custom_colors.dart';
import '../../utils/spacers.dart';
import '../../widgets/confession_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Confessions",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: CustomColors.blackBgColor,
                fontSize: 30),
          ),
          verticalSpacer(20),
          Container(
            decoration: BoxDecoration(
                color: CustomColors.greyBgColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.magnifyingGlass,
                        size: 14,
                        color: CustomColors.blackBgColor,
                      ),
                      horizontalSpacer(15),
                      const Text(
                        "Search Confessions",
                        style: TextStyle(
                            color: CustomColors.greyTextColor, fontSize: 14),
                      ),
                    ],
                  ),
                  const FaIcon(
                    FontAwesomeIcons.barsProgress,
                    size: 14,
                    color: CustomColors.blackBgColor,
                  ),
                ],
              ),
            ),
          ),
          verticalSpacer(20),
          Expanded(
            child: ListView.builder(
                itemCount: 4,
                itemBuilder: ((context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: ConfessionContainer(),
                  );
                })),
          ),
        ],
      ),
    );
  }
}
