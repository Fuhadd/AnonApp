import 'package:anon/models/communities_model.dart';
import 'package:anon/screens/communities/communities_details_screen.dart';
import 'package:anon/screens/communities/communities_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../constants/custom_colors.dart';
import '../../utils/community_icons_list.dart';
import '../../utils/spacers.dart';
import '../../widgets/quick_access.dart';
import 'community_create_screen.dart';

class CommunitiesScreen2 extends ConsumerStatefulWidget {
  final List<Community> discoveredCommunities;
  const CommunitiesScreen2({
    super.key,
    required this.discoveredCommunities,
  });

  @override
  ConsumerState<CommunitiesScreen2> createState() => _CommunitiesScreen2State();
}

class _CommunitiesScreen2State extends ConsumerState<CommunitiesScreen2>
    with SingleTickerProviderStateMixin {
  // late Future<List<Community>> _futureData;
  bool fetchFuture = true;
  late TabController _tabController;

  @override
  void initState() {
    _tabController =
        TabController(length: 2, vsync: this, initialIndex: 0); // Create Ta
    // _tabController.addListener(_handleTabSelection);
    super.initState();
    // _futureData = fetchData(); // Replace with your data retrieval logic
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (ref.watch(discoveredCommunitiesProvider).isEmpty) {
    //     print(11111);
    //     fetchFuture = true;
    //     // _futureData = fetchCachedData();
    //   } else {
    //     print(222222);
    //     fetchFuture = false;
    //     // _futureData = fetchData();
    //   }
    // });
  }

  // Future<List<Community>> fetchCachedData() async {
  //   // Perform the asynchronous operation to fetch data
  //   // ...
  //   // Return the fetched data
  //   return ref.watch(discoveredCommunitiesProvider);
  // }

  Future<List<Community>> fetchdiscoveredCommunities() async {
    // Perform the asynchronous operation to fetch data
    // ...
    // Return the fetched data
    return await CommunityViewModel.initWhoAmI().discoverNewCommunities(ref);
  }

  Future<List<Community>> fetchMyCommunities() async {
    // Perform the asynchronous operation to fetch data
    // ...
    // Return the fetched data
    await Future.delayed(const Duration(seconds: 5));
    return await CommunityViewModel.initWhoAmI().fetchMyCommunities(ref);
  }

  @override
  Widget build(BuildContext context) {
    var data = ["Relationships", "LGBT Support", "Anime", "Gaming", "Football"];
    // final discoveredCommunities = ref.watch(discoveredCommunitiesProvider);
    // final discoveredCommunities = ref.read(discoveredCommunitiesProvider);
    return Scaffold(
      backgroundColor: CustomColors.whiteBgColor,
      body: SizedBox(
        // color: Colors.white,
        // height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: CustomColors.whiteBgColor,
              child: Column(
                children: [
                  verticalSpacer(10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
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
                              "Get emotional advice, aske questions",
                              style: TextStyle(
                                  color:
                                      CustomColors.greyBgColor.withOpacity(0.7),
                                  fontSize: 15),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const CommunityCreateScreen())));
                          },
                          child: Container(
                              // margin:
                              //     const EdgeInsets.only(top: 5, bottom: 5),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: CustomColors.mainBlueColor
                                      .withOpacity(0.6)),
                              child: const Center(
                                child: Icon(
                                  FontAwesomeIcons.plus,
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
                  ),

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
                  //Recent
                  //Discover
                  verticalSpacer(20),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 90,
                          child: TabBar(
                            isScrollable: true,
                            indicatorSize: TabBarIndicatorSize.label,
                            labelColor: CustomColors.blackColor,
                            unselectedLabelColor:
                                CustomColors.blackBgColor.withOpacity(0.4),
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
                            controller:
                                _tabController, // Assign TabController to TabBar
                            tabs: const [
                              Tab(
                                text: 'My Communities',
                              ),
                              Tab(
                                text: 'Discover',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 40,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            verticalSpacer(20),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller:
                      _tabController, // Assign TabController to TabBarView
                  children: [
                    CommunitiesFutureBuilder(
                      ref: ref,
                      fetchData: fetchMyCommunities(),
                      isMember: true,
                    ),
                    CommunitiesFutureBuilder(
                      ref: ref,
                      fetchData: fetchdiscoveredCommunities(),
                      isMember: false,
                    ),
                  ],
                ),
              ),
            ),

            // verticalSpacer(30),
            // widget.discoveredCommunities.isNotEmpty
            //     ? SizedBox(
            //         height: 300,
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //           child: GridView.builder(
            //             shrinkWrap: true,
            //             // clipBehavior: ,// Set to true to enable scrolling in ListView
            //             // physics:
            //             //     const NeverScrollableScrollPhysics(), // Disable scrolling in ListView
            //             gridDelegate:
            //                 SliverGridDelegateWithFixedCrossAxisCount(
            //               crossAxisCount:
            //                   2, // Set to 2 to display items in pairs
            //               childAspectRatio:
            //                   0.85, // Set aspect ratio to 1 to maintain square shape
            //               crossAxisSpacing: 20,
            //               // Set spacing between columns
            //               mainAxisSpacing:
            //                   MediaQuery.of(context).size.width * 0.049,
            //             ),
            //             // itemCount: data.length,
            //             itemCount: 3,
            //             itemBuilder: (context, index) {
            //               return QuickAccess(
            //                 title: widget.discoveredCommunities[index].name,
            //                 message: 'View all your scheduled\nappointments',
            //                 quickIcon: communityIconList[
            //                     widget.discoveredCommunities[index].icon],
            //                 quickIconColor: const Color(0xff000000),
            //                 quickTitleColor: const Color(0xff000000),
            //                 quickBackgroundColor: CustomColors
            //                         .communityColorList[
            //                     widget.discoveredCommunities[index].color],
            //                 quickBorderColor: CustomColors.communityColorList[
            //                     widget.discoveredCommunities[index].color],
            //                 quickRoute: CommunitiesDetailsScreen.routeName,
            //               );
            //             },
            //           ),
            //         ),
            //       )
            //     : Expanded(
            //         child: CommunitiesFutureBuilder(
            //           ref: ref,
            //           fetchData: fetchData(),
            //         ),
            //       ),

            // verticalSpacer(30),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //   child: Column(
            //     children: [
            //       Row(
            //         children: [
            //           const QuickAccess(
            //             title: 'Relationship',
            //             message: 'View all your scheduled\nappointments',
            //             quickIcon: FontAwesomeIcons.heartPulse,
            //             quickIconColor: Color(0xff000000),
            //             quickTitleColor: Color(0xff000000),
            //             quickBackgroundColor: Color(0xfffdba16),
            //             quickBorderColor: Color(0xfffdba16),
            //             quickRoute: CommunitiesDetailsScreen.routeName,
            //             quickAbout: ,
            //           ),
            //           SizedBox(
            //               width: MediaQuery.of(context).size.width * 0.049),
            //           const QuickAccess(
            //             title: 'Football',
            //             message: 'See all your medical history timeline',
            //             quickIcon: FontAwesomeIcons.futbol,
            //             quickIconColor: Color(0xff000000),
            //             quickTitleColor: Color(0xff000000),
            //             quickBackgroundColor: Color(0xff53a4df),
            //             quickBorderColor: Color(0xff53a4df),
            //             quickRoute: CommunitiesDetailsScreen.routeName,
            //           ),
            //         ],
            //       ),
            //       SizedBox(
            //           height: MediaQuery.of(context).size.height * 0.021),
            //       Row(
            //         children: [
            //           const QuickAccess(
            //             title: 'LBGTQ Support',
            //             message: 'See all your number of dependents',
            //             quickIcon: FontAwesomeIcons.rainbow,
            //             quickIconColor: Color(0xff000000),
            //             quickTitleColor: Color(0xff000000),
            //             quickBackgroundColor: Color(0xff88c177),
            //             quickBorderColor: Color(0xff88c177),
            //             quickRoute: CommunitiesDetailsScreen.routeName,
            //           ),
            //           SizedBox(
            //               width: MediaQuery.of(context).size.width * 0.049),
            //           const QuickAccess(
            //             title: 'Gaming',
            //             message: 'See all your hospitals',
            //             quickIcon: FontAwesomeIcons.gamepad,
            //             quickIconColor: Color(0xff000000),
            //             quickTitleColor: Color(0xff000000),
            //             quickBackgroundColor: Color(0xffbc8a5d),
            //             quickBorderColor: Color(0xffbc8a5d),
            //             quickRoute: CommunitiesDetailsScreen.routeName,
            //           ),
            //         ],
            //       ),
            //       SizedBox(
            //           height: MediaQuery.of(context).size.height * 0.021),
            //       Row(
            //         children: [
            //           const QuickAccess(
            //             title: 'Anime',
            //             message: 'See all your benefits',
            //             quickIcon: FontAwesomeIcons.film,
            //             quickIconColor: Color(0xff000000),
            //             quickTitleColor: Color(0xff000000),
            //             quickBackgroundColor: Color(0xfff45e5e),
            //             quickBorderColor: Color(0xfff45e5e),
            //             quickRoute: CommunitiesDetailsScreen.routeName,
            //           ),
            //           SizedBox(
            //               width: MediaQuery.of(context).size.width * 0.049),
            //           const QuickAccess(
            //             title: 'Series / Movies',
            //             message: 'Check out our telemedicine features',
            //             quickIcon: FontAwesomeIcons.camera,
            //             quickIconColor: Color(0xff000000),
            //             quickTitleColor: Color(0xff000000),
            //             quickBackgroundColor: Color(0xff6d78ad),
            //             quickBorderColor: Color(0xff6d78ad),
            //             quickRoute: CommunitiesDetailsScreen.routeName,
            //           ),
            //         ],
            //       ),
            //       SizedBox(
            //           height: MediaQuery.of(context).size.height * 0.021),
            //       Row(
            //         children: [
            //           const QuickAccess(
            //             title: 'Matured Minds',
            //             message: 'Apply for and view all payment refunds',
            //             quickIcon: FontAwesomeIcons.circleXmark,
            //             quickIconColor: Color(0xff000000),
            //             quickTitleColor: Color(0xff000000),
            //             quickBackgroundColor: Color(0xff44b4a8),
            //             quickBorderColor: Color(0xff44b4a8),
            //             quickRoute: CommunitiesDetailsScreen.routeName,
            //           ),
            //           SizedBox(
            //               width: MediaQuery.of(context).size.width * 0.049),
            //           const QuickAccess(
            //             title: 'Authentication',
            //             message:
            //                 'Check if you have been authenticated for a medical care',
            //             quickIcon: FontAwesomeIcons.unlock,
            //             quickIconColor: Color(0xff000000),
            //             quickTitleColor: Color(0xff000000),
            //             quickBackgroundColor: Color(0xff8f649e),
            //             quickBorderColor: Color(0xff8f649e),
            //             quickRoute: CommunitiesDetailsScreen.routeName,
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),

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
            // Expanded(
            //   child: GridView.builder(
            //     shrinkWrap: true,
            //     // clipBehavior: ,// Set to true to enable scrolling in ListView
            //     // physics:
            //     //     const NeverScrollableScrollPhysics(), // Disable scrolling in ListView
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2, // Set to 2 to display items in pairs
            //       childAspectRatio:
            //           0.6, // Set aspect ratio to 1 to maintain square shape
            //       crossAxisSpacing: 20,
            //       // Set spacing between columns
            //       mainAxisSpacing: 30,
            //     ),
            //     itemCount: data.length,
            //     itemBuilder: (context, index) {
            //       return CommunitiesContainer(
            //         title: data[index],
            //       );
            //     },
            //   ),
            // ),

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
      ),
    );
  }
}

class CommunitiesFutureBuilder extends StatelessWidget {
  const CommunitiesFutureBuilder({
    super.key,
    required this.ref,
    required this.fetchData,
    required this.isMember,
  });

  final WidgetRef ref;
  final Future<List<Community>> fetchData;
  final bool isMember;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // initialData: discoveredCommunities,
      // future:
      //     CommunityViewModel.initWhoAmI().discoverNewCommunities(),
      // future: fetchData(),
      // future: CommunityViewModel.initWhoAmI().discoverNewCommunities(ref),
      future: fetchData,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  "assets/animations/loading_animation.json",
                  height: 150,
                  width: 150,
                  animate: true,
                  repeat: true,
                  reverse: false,
                  fit: BoxFit.contain,
                ),
                // verticalSpacer(20),
                // Text(
                //   "You have no  confessions available at the moment, share link below",
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //       color: CustomColors.greyBgColor.withOpacity(0.7),
                //       fontSize: 15),
                // ),
              ],
            ),
          );
        }

        if (snapshot.hasData) {
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   ref.read(discoveredCommunitiesProvider.notifier).state =
          //       snapshot.data!;
          // });

          final data = snapshot.data;

          if (snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    "assets/animations/no-transaction-history.json",
                    height: 150,
                    width: 150,
                    animate: true,
                    repeat: true,
                    reverse: false,
                    fit: BoxFit.contain,
                  ),
                  verticalSpacer(20),
                  Text(
                    "You have no  confessions available at the moment, share link below",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: CustomColors.greyBgColor.withOpacity(0.7),
                        fontSize: 15),
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GridView.builder(
              shrinkWrap: true,
              // clipBehavior: ,// Set to true to enable scrolling in ListView
              // physics:
              //     const NeverScrollableScrollPhysics(), // Disable scrolling in ListView
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Set to 2 to display items in pairs
                childAspectRatio:
                    0.88, // Set aspect ratio to 1 to maintain square shape
                crossAxisSpacing: 20,
                // Set spacing between columns
                mainAxisSpacing: MediaQuery.of(context).size.width * 0.049,
              ),
              itemCount: snapshot.data!.length,
              // itemCount: 1,
              itemBuilder: (context, index) {
                return QuickAccess(
                  title: snapshot.data![index].name,
                  message: snapshot.data![index].description,
                  quickIcon: communityIconList[snapshot.data![index].icon],
                  quickIconColor: const Color(0xff000000),
                  quickTitleColor: const Color(0xff000000),
                  quickBackgroundColor: CustomColors
                      .communityColorList[snapshot.data![index].color],
                  quickBorderColor: CustomColors
                      .communityColorList[snapshot.data![index].color],
                  quickRoute: CommunitiesDetailsScreen.routeName,
                  isMember: isMember,
                  communityId: snapshot.data![index].id,
                );
              },
            ),
          );
          // return Text('Received data: $data');
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/animations/loading_animation.json",
                height: 150,
                width: 150,
                animate: true,
                repeat: true,
                reverse: false,
                fit: BoxFit.contain,
              ),
              // verticalSpacer(20),
              // Text(
              //   "You have no  confessions available at the moment, share link below",
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //       color: CustomColors.greyBgColor.withOpacity(0.7),
              //       fontSize: 15),
              // ),
            ],
          ),
        );
      },
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
