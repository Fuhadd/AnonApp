import 'package:anon/constants/custom_colors.dart';
import 'package:anon/constants/custom_string.dart';
import 'package:anon/locator.dart';
import 'package:anon/models/app_user_model.dart';
import 'package:anon/models/confession_response_model.dart';
import 'package:anon/screens/confessions/confession_send_screen.dart';
import 'package:anon/screens/confessions/confession_streambuilder.dart';
import 'package:anon/utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../data/local_cache/local_cache.dart';
import '../../utils/branch_functions.dart';
import '../../utils/clipboard_toaster.dart';
import 'confession_view_model.dart';

class InitialConfessionScreen extends StatefulHookConsumerWidget {
  const InitialConfessionScreen({super.key});

  @override
  ConsumerState<InitialConfessionScreen> createState() =>
      _InitialConfessionScreenState();
}

class _InitialConfessionScreenState
    extends ConsumerState<InitialConfessionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController scrollController;
  double scrolling = 0;
  int currentVisibleItemIndex = 0;
  late AppUser userData;
  late Object? userLink;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    ); // Create Ta
    scrollController = ScrollController();
    scrollController.addListener(scrollListernerWithCount);
    userData = locator<LocalCache>().getUserData();
    userLink =
        locator<LocalCache>().getFromLocalCache(ConstantString.referralLink);

    // locator<LocalCache>().removeFromLocalCache(ConstantString.referralLink);
    if (userLink == null) {
      BranchFunctions.generateLink(
        userData.userName,
        userData.id!,
        userData.avatarUrl,
        onOkPressed: () {
          setState(() {
            userLink = locator<LocalCache>()
                .getFromLocalCache(ConstantString.referralLink);
          });
          Navigator.pop(context);
        },
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final confessionVM = ref.watch(confessionProvider);
    final initialConfessions = ref.read(confessionsProviderList);
    // var userLink =
    //     locator<LocalCache>().getFromLocalCache(ConstantString.referralLink) ==
    //             null
    //         ? ""
    //         : locator<LocalCache>()
    //             .getFromLocalCache(ConstantString.referralLink)
    //             .toString();
    ConfessionResponse testData = ConfessionResponse(
      id: "id",
      imageUrl: "imageUrl",
      userName: "@elvis",
      title: "Send An Anonymous Message",
      content:
          "I have something to confess that has been eating away at me. It's about love—a love that caught me completely off guard. I never expected to feel this way, but here I am, hopelessly smitten. Every time I see them, my heart races, and my mind goes blank. It's like ",
    );
    ConfessionResponse testData2 = ConfessionResponse(
      id: "id",
      imageUrl: "imageUrl",
      userName: "@princess",
      title: "Had a bad day at the gym, I'm wheezing",
      content:
          "You won't believe the kind of day I had at the gym today. It was an absolute disaster, and I'm still wheezing from the exhaustion and frustration. Everything seemed to go wrong right from the start. ",
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
                            builder: ((context) => const ConfessionSendScreen(
                                // destinationId: "33UTvAD92WedvsWV3pu54QXMWvm1",
                                // destinationImage:
                                //     "https://firebasestorage.googleapis.com/v0/b/anon-c0a35.appspot.com/o/anonAvatarImages%2Fskull.png?alt=media&token=987fa747-14ed-48d2-b758-085da61625da",
                                // destinationName: "Harminu",
                                ))));
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
              "Confess, connect, embrace understanding",
              style: TextStyle(
                  color: CustomColors.greyBgColor.withOpacity(0.7),
                  fontSize: 14),
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
                        GestureDetector(
                          onTap: userLink == null
                              ? null
                              : () async {
                                  await Clipboard.setData(
                                      ClipboardData(text: userLink.toString()));
                                  ToastNotification.show(
                                      context: context,
                                      toastMessage: "Copied to clipboard!");
                                },
                          child: const Icon(
                            Icons.copy,
                            size: 20,
                          ),
                        ),
                        horizontalSpacer(20),
                        SizedBox(
                          width: 230,
                          child: Text(
                            // "wispers.app.link/6xTFRMWW2j doudnidujndiundidnidnidbdibdidbiAb",
                            userLink == null ? "" : userLink.toString(),
                            // textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: CustomColors.greyBgColor,
                                fontSize: 11.5),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Share.share(
                            "Send me anonymous messages on Wispers!\n ${userLink.toString()} \nLet's connect and have open conversations. Looking forward to hearing from you!",
                            subject: 'Send me an anonymous message');
                      },
                      child: const Text(
                        "Share",
                        style: TextStyle(color: CustomColors.mainBlueColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            verticalSpacer(10),
            TabBar(
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: CustomColors.blackColor,
              unselectedLabelColor: CustomColors.blackBgColor.withOpacity(0.4),
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),

              indicator: const BoxDecoration(
                // borderRadius: BorderRadius.circular(10),
                border: Border(
                  bottom: BorderSide(
                    color: CustomColors.blackBgColor,
                  ),
                ),
                color: Colors.transparent,
              ),
              controller: _tabController, // Assign TabController to TabBar
              tabs: const [
                Tab(
                  text: 'Unread',
                ),
                Tab(
                  text: 'Read',
                ),
              ],
            ),
            // verticalSpacer(20),
            // verticalSpacer(10),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller:
                    _tabController, // Assign TabController to TabBarView
                children: const [
                  ConfessionStreamBuilder(read: false),
                  ConfessionStreamBuilder(read: true)
                  // DirectMessagesScreen(),
                  // GroupMessagesScreen(),
                ],
              ),
            ),
            // StreamBuilder(
            //     stream: confessionVM.getAllConfessionStream(),
            //     builder: (context, snapshot) {
            //       if (snapshot.hasError) {
            //         return Text('Error${snapshot.error}');
            //       }
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return const CircularProgressIndicator();
            //       }
            //       return ConfessionCard(
            //         snapshot: snapshot,
            //       );
            //     })
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: 5,
            //     controller: scrollController,
            //     itemBuilder: (context, index) {
            //       return SlantedContainer(
            //         index: index,
            //         currentVisibleItemIndex: currentVisibleItemIndex,
            //         scrolling: scrolling,
            //         confession: index == 0 ? testData : testData2,
            //       );
            //       // return PerspectiveWidgetx(
            //       //     index, currentVisibleItemIndex, scrolling);
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  void scrollListernerWithCount() {
    int itemCount = 10;
    double scrollOffset = scrollController.position.pixels;
    double viewportHeight = scrollController.position.viewportDimension;
    double scrollRange = scrollController.position.maxScrollExtent -
        scrollController.position.minScrollExtent;
    int firstVisibleItemIndex =
        (scrollOffset / (scrollRange + viewportHeight) * itemCount).floor();
    currentVisibleItemIndex = firstVisibleItemIndex;
    scrolling = (scrollOffset / (scrollRange + viewportHeight) * itemCount);
    scrolling = double.parse(scrolling.toStringAsFixed(2));
    setState(() {
      print(firstVisibleItemIndex);
    });
  }
}
