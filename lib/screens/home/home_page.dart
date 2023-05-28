import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants/custom_colors.dart';
import '../../utils/spacers.dart';
import '../../widgets/support_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool animationCompleted = false;
  bool showDailyCheckin = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceInOut,
      ),
    );

    // Future.delayed(const Duration(seconds: 2)).then((value) {
    //   _startAnimation();
    // });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _animationController.reset();
    _animationController.forward().whenComplete(() {
      setState(() {
        // animationCompleted = true;
        if (!animationCompleted) {
          // _animationController.resync(this);
          _animationController.reset();
          _animationController.forward().whenComplete(() {
            setState(() {
              showDailyCheckin = false;
            });
          });
          // .repeat()
          // .whenComplete(() => _animationController.stop());
          animationCompleted = true;
        }
        // _animationController.repeat();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

    var data = ["Relationships", "LGBT Support", "Anime", "Gaming", "Football"];
    final DateTime now = DateTime.now();
    final int hour = now.hour;

    String greeting;

    if (hour < 12) {
      greeting = 'Good Morning!';
    } else if (hour < 17) {
      greeting = 'Good Afternoon!';
    } else {
      greeting = 'Good Evening!';
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              greeting,
              // "Good Afternoon!",
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: CustomColors.blackBgColor,
                  fontSize: 30),
            ),
            verticalSpacer(10),
            Text(
              "82,348 people are here today",
              style: TextStyle(
                  color: CustomColors.greyBgColor.withOpacity(0.7),
                  fontSize: 15),
            ),
            verticalSpacer(30),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: CustomColors.mainBlueColor,
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
                padding: const EdgeInsets.only(left: 20.0, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Five principles of living Mindfully",
                              style: TextStyle(
                                  color: CustomColors.whiteColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700),
                            ),
                            const Text(
                              "with Natalie James",
                              style: TextStyle(
                                  color: CustomColors.whiteColor, fontSize: 13),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                // width: 120,
                                decoration: BoxDecoration(
                                  color: CustomColors.blackBgColor
                                      .withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Today - 08:30 PM",
                                    style: TextStyle(
                                        color: CustomColors.whiteColor,
                                        fontSize: 13),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 250,
                        child: Image(
                            image: AssetImage(
                                "assets/images/relationship_nobg2.png"),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            verticalSpacer(30),
            showDailyCheckin
                ? AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform(
                          alignment: Alignment.topCenter,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateX(3.14 * _animation.value),
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.0, 0.0),
                              end: animationCompleted
                                  ? const Offset(0.0, -10.0)
                                  : const Offset(0.0, -1.0),
                            ).animate(_animationController),
                            child: FlipCard(
                              key: cardKey,
                              flipOnTouch: false,
                              onFlipDone: (isFront) async {
                                await Future.delayed(
                                    const Duration(seconds: 2));
                                _startAnimation();
                              },
                              front: CheckInContainer(
                                cardKey: cardKey,
                              ),
                              back: Container(
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    verticalSpacer(6),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 20, top: 25),
                                      child: Text(
                                        "Daily Check in",
                                        style: TextStyle(
                                            color: CustomColors.greyBgColor
                                                .withOpacity(0.7),
                                            fontSize: 13),
                                      ),
                                    ),
                                    verticalSpacer(20),
                                    Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 20.0,
                                            right: 20,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.quoteLeft,
                                                color: CustomColors.greyBgColor
                                                    .withOpacity(0.7),
                                                size: 20,
                                              ),
                                              horizontalSpacer(10),
                                              Expanded(
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: <InlineSpan>[
                                                      // WidgetSpan(
                                                      //   child: Padding(
                                                      //     padding:
                                                      //         const EdgeInsets.only(right: 5.0),
                                                      //     child: FaIcon(
                                                      //       FontAwesomeIcons.quoteLeft,
                                                      //       color: CustomColors.greyBgColor
                                                      //           .withOpacity(0.7),
                                                      //       size: 20,
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      TextSpan(
                                                        text:
                                                            "Great Todays happinees i the key to tomooroww?",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: CustomColors
                                                                .blackColor
                                                                .withOpacity(
                                                                    0.8),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      WidgetSpan(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10.0),
                                                          child: FaIcon(
                                                            FontAwesomeIcons
                                                                .quoteRight,
                                                            color: CustomColors
                                                                .greyBgColor
                                                                .withOpacity(
                                                                    0.7),
                                                            size: 20,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )

                                          // Row(
                                          //   children: [
                                          //     Align(
                                          //       alignment: Alignment.topLeft,
                                          //       child: FaIcon(
                                          //         FontAwesomeIcons.quoteLeft,
                                          //         color: CustomColors.greyBgColor.withOpacity(0.7),
                                          //         size: 20,
                                          //       ),
                                          //     ),
                                          //     horizontalSpacer(10),
                                          //     Expanded(
                                          //       child: Text(
                                          //         "Great Todays happinees i the key to tomooroww?",
                                          //         style: TextStyle(
                                          //             fontSize: 16,
                                          //             color:
                                          //                 CustomColors.blackColor.withOpacity(0.8),
                                          //             fontWeight: FontWeight.w600),
                                          //       ),
                                          //     ),
                                          //     horizontalSpacer(10),
                                          //     FaIcon(
                                          //       FontAwesomeIcons.quoteRight,
                                          //       color: CustomColors.greyBgColor.withOpacity(0.7),
                                          //       size: 20,
                                          //     ),
                                          //   ],
                                          // ),
                                          ),
                                    ),
                                    verticalSpacer(20),
                                    const Divider(),
                                    verticalSpacer(10),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Aminu Fuhad",
                                            style: TextStyle(
                                                color: CustomColors.greyBgColor
                                                    .withOpacity(0.7),
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ),
                                    verticalSpacer(30),
                                  ],
                                ),
                              ),
                            ),
                          ));
                    })
                : const SizedBox.shrink(),
            showDailyCheckin ? verticalSpacer(30) : const SizedBox.shrink(),
            Container(
              // height: 250,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpacer(6),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 20, top: 25),
                    child: Text(
                      "let us support you!!",
                      style: TextStyle(
                          color: CustomColors.greyBgColor.withOpacity(0.7),
                          fontSize: 13),
                    ),
                  ),
                  verticalSpacer(20),
                  SupportContainer(
                    iconBgColor: CustomColors.mainBlueColor,
                    containerIcon: SvgPicture.asset(
                      "assets/icons/message.svg",
                      height: 25,
                    ),
                    title: "Chat",
                    subTitle: "Connect 1-1 and group chat",
                  ),
                  verticalSpacer(20),
                  SupportContainer(
                    iconBgColor: CustomColors.electricBlue,
                    containerIcon: SvgPicture.asset(
                      "assets/icons/people.svg",
                      height: 25,
                      // width: 10,
                    ),
                    title: "Community",
                    subTitle: "Ask questions, get support",
                  ),
                  verticalSpacer(20),
                  SupportContainer(
                    iconBgColor: CustomColors.royalPurple,
                    containerIcon: SvgPicture.asset(
                      "assets/icons/bulb.svg",
                      height: 25,
                    ),
                    title: "Confession",
                    subTitle: "Share your stories, find understanding",
                  ),
                  verticalSpacer(25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckInContainer extends StatelessWidget {
  const CheckInContainer({
    super.key,
    required this.cardKey,
  });
  final GlobalKey<FlipCardState> cardKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 250,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpacer(6),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 25),
            child: Text(
              "Daily Check in",
              style: TextStyle(
                  color: CustomColors.greyBgColor.withOpacity(0.7),
                  fontSize: 13),
            ),
          ),
          verticalSpacer(20),
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20,
            ),
            child: Text(
              "How are you feeling today?",
              style: TextStyle(
                  fontSize: 18,
                  color: CustomColors.blackColor.withOpacity(0.8),
                  fontWeight: FontWeight.w600),
            ),
          ),
          verticalSpacer(20),
          Row(
            children: [
              horizontalSpacer(20),
              FeelingsContainer(
                title: "Great",
                emoji: "😄",
                cardKey: cardKey,
              ),
              horizontalSpacer(10),
              FeelingsContainer(
                title: "Good",
                emoji: "🙂",
                cardKey: cardKey,
              ),
              horizontalSpacer(10),
              FeelingsContainer(
                title: "Okay",
                emoji: "😶",
                cardKey: cardKey,
              ),
              horizontalSpacer(20),
            ],
          ),
          verticalSpacer(20),
          Row(
            children: [
              horizontalSpacer(20),
              FeelingsContainer(
                title: "Sad",
                emoji: "😥",
                cardKey: cardKey,
              ),
              horizontalSpacer(10),
              FeelingsContainer(
                title: "Awful",
                emoji: "😞",
                cardKey: cardKey,
              ),
              horizontalSpacer(10),
              FeelingsContainer(
                title: "Angry",
                emoji: "😠",
                cardKey: cardKey,
              ),
              horizontalSpacer(20),
            ],
          ),

          // verticalSpacer(25),
          // Row(
          //   children: [
          //     const Text(
          //       "Join group",
          //       style: TextStyle(
          //         color: CustomColors.mainBlueColor,
          //       ),
          //     ),
          //     horizontalSpacer(4),
          //     const Icon(
          //       Icons.arrow_forward,
          //       color: CustomColors.mainBlueColor,
          //     ),
          //   ],
          // ),
          verticalSpacer(25),
        ],
      ),
    );
  }
}

class FeelingsContainer extends StatelessWidget {
  const FeelingsContainer({
    super.key,
    required this.emoji,
    required this.title,
    required this.cardKey,
    this.transparent = false,
  });
  final String title;
  final String emoji;
  final bool transparent;
  final GlobalKey<FlipCardState> cardKey;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: transparent
          ? Container()
          : GestureDetector(
              onTap: () {
                cardKey.currentState == null
                    ? null
                    : cardKey.currentState!.toggleCard();
              },
              child: Container(
                height: 40,
                width: double.infinity,
                // width: 120,
                decoration: BoxDecoration(
                  color: CustomColors.mainBlueColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(emoji),
                    horizontalSpacer(5),
                    Text(
                      title,
                      style: TextStyle(
                          color: CustomColors.blackColor.withOpacity(0.8),
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                  ],
                )),
              ),
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
