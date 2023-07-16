import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/custom_colors.dart';
import '../../utils/spacers.dart';
import 'communities_view_model.dart';

class CommunitiesScreen extends ConsumerStatefulWidget {
  const CommunitiesScreen({
    super.key,
  });

  @override
  ConsumerState<CommunitiesScreen> createState() => _CommunitiesScreenState();
}

class _CommunitiesScreenState extends ConsumerState<CommunitiesScreen> {
  @override
  Widget build(BuildContext context) {
    var data = ["Relationships", "LGBT Support", "Anime", "Gaming", "Football"];
    final discoveredCommunities = ref.watch(discoveredCommunitiesProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Communities",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: CustomColors.blackBgColor,
                fontSize: 30),
          ),
          verticalSpacer(10),
          Text(
            "Get emotional advice, ask questions",
            style: TextStyle(
                color: CustomColors.greyBgColor.withOpacity(0.7), fontSize: 15),
          ),
          verticalSpacer(20),
          // Container(
          //   decoration: BoxDecoration(
          //       color: CustomColors.mainBlueColor,
          //       borderRadius: BorderRadius.circular(12)),
          //   child: Padding(
          //     padding:
          //         const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         const FaIcon(
          //           FontAwesomeIcons.rocket,
          //           color: CustomColors.blackBgColor,
          //           size: 17,
          //         ),
          //         horizontalSpacer(12),
          //         const Text(
          //           "Explore",
          //           style: TextStyle(
          //               fontWeight: FontWeight.w700,
          //               color: CustomColors.whiteColor,
          //               fontSize: 18),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          verticalSpacer(20),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: data.length ~/ 2, // Round down to the nearest integer
          //     itemBuilder: (context, index) {
          //       return Row(
          //         children: [
          //           const CommunitiesContainer(),
          //           horizontalSpacer(20),
          //           if (index * 2 + 1 < data.length)
          //             const CommunitiesContainer(),
          //         ],
          //       );
          //     },
          //   ),
          // ),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              // clipBehavior: ,// Set to true to enable scrolling in ListView
              // physics:
              //     const NeverScrollableScrollPhysics(), // Disable scrolling in ListView
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Set to 2 to display items in pairs
                childAspectRatio:
                    0.6, // Set aspect ratio to 1 to maintain square shape
                crossAxisSpacing: 20,
                // Set spacing between columns
                mainAxisSpacing: 30,
              ),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return CommunitiesContainer(
                  title: data[index],
                );
              },
            ),
          ),

          // Row(
          //   children: [
          //     const CommunitiesContainer(),
          //     horizontalSpacer(20),
          //     const CommunitiesContainer(),
          //   ],
          // )
          // Expanded(
          //   child: ListView.builder(
          //       itemCount: 4,
          //       itemBuilder: ((context, index) {
          //         return const Padding(
          //           padding: EdgeInsets.only(bottom: 20.0),
          //           child: ConfessionContainer(),
          //         );
          //       })),
          // ),
        ],
      ),
    );
  }
}

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
              // "Relationships",
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
