import 'package:anon/constants/custom_colors.dart';
import 'package:anon/models/confession_response_model.dart';
import 'package:anon/screens/confessions/confession_send_screen.dart';
import 'package:anon/utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'confession_view_model.dart';

class InitialConfessionScreen extends StatefulHookConsumerWidget {
  const InitialConfessionScreen({super.key});

  @override
  ConsumerState<InitialConfessionScreen> createState() =>
      _InitialConfessionScreenState();
}

class _InitialConfessionScreenState
    extends ConsumerState<InitialConfessionScreen> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final confessionVM = ref.watch(confessionProvider);
    final initialConfessions = ref.read(confessionsProvider);
    ConfessionResponse testData = ConfessionResponse(
      id: "id",
      imageUrl: "imageUrl",
      userName: "@elvis",
      title: "Had a bad day at the gym, I'm wheezing",
      content:
          "Unlimited cards and spaces, investments tips and much more more more more more more more more more more more more more more more more more",
    );
    return Scaffold(
      backgroundColor: CustomColors.whiteBgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpacer(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Confessions",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: CustomColors.blackBgColor,
                      fontSize: 30),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>
                                const ConfessionSendScreen())));
                  },
                  child: Container(
                      // margin:
                      //     const EdgeInsets.only(top: 5, bottom: 5),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: CustomColors.mainBlueColor.withOpacity(0.6)),
                      child: const Center(
                        child: Icon(
                          FontAwesomeIcons.paperPlane,
                          size: 18,
                          color: CustomColors.whiteColor,
                        ),
                        // FaIcon(
                        //   FontAwesomeIcons.message,
                        //   size: 20,
                        // ),
                      )),
                ),
              ],
            ),
            verticalSpacer(10),
            Text(
              "Get emotional advice, ask questions",
              style: TextStyle(
                  color: CustomColors.greyBgColor.withOpacity(0.7),
                  fontSize: 15),
            ),
            verticalSpacer(20),
            Container(
              height: 50,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.copy,
                          size: 20,
                        ),
                        horizontalSpacer(20),
                        const Text(
                          "wispers.app.link/6xTFRMWW2Ab",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: CustomColors.greyBgColor, fontSize: 12),
                        ),
                      ],
                    ),
                    const Text(
                      "Share",
                      style: TextStyle(color: CustomColors.mainBlueColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
