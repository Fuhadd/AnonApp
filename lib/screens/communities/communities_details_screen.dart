import 'package:anon/components/generic_dialog.dart';
import 'package:anon/screens/communities/create_post_screen.dart';
import 'package:anon/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../constants/custom_colors.dart';
import '../../data/local_cache/local_cache.dart';
import '../../locator.dart';
import '../../models/post_model.dart';
import '../../utils/spacers.dart';
import '../../widgets/animated_bottom_up.dart';
import '../../widgets/custom_noborder_textfield.dart';
import 'communities_view_model.dart';

class CommunitiesDetailsScreen extends ConsumerStatefulWidget {
  const CommunitiesDetailsScreen({
    super.key,
  });

  static const String routeName = "communities_details";

  @override
  ConsumerState<CommunitiesDetailsScreen> createState() =>
      _CommunitiesDetailsScreenState();
}

class _CommunitiesDetailsScreenState
    extends ConsumerState<CommunitiesDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int activeIndex = -1;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    ); // Create Ta
    // _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  Future<List<Post>> fetchallCommunityPosts(String communityId) async {
    // Perform the asynchronous operation to fetch data
    // ...
    // Return the fetched data
    return await CommunityViewModel.initWhoAmI()
        .fetchallCommunityPosts(ref, communityId);
  }

  Future<List<Post>> fetchMyCommunityPosts(String communityId) async {
    // Perform the asynchronous operation to fetch data
    // ...
    // Return the fetched data
    await Future.delayed(const Duration(seconds: 5));
    return await CommunityViewModel.initWhoAmI()
        .fetchallCommunityPosts(ref, communityId);
  }

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context)?.settings.arguments as Map;

    final Color mainColor = args['color'];
    final Color transMainColor = mainColor.withOpacity(0.5);
    final String title = args['title'];
    final IconData icon = args['icon'];
    final String message = args['message'];
    final bool isMember = args['isMember'];
    final String communityId = args['communityId'];
    List<String> discussions = [
      "marriage",
      "longdistance",
      "intimacy",
      "findlove",
      "cheating"
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      // backgroundColor: const mainColor.withOpacity(0.5),
      // appBar: AppBar(
      //   elevation: 0,
      //   centerTitle: false,
      //   automaticallyImplyLeading: false,
      //   backgroundColor: mainColor.withOpacity(0.5),
      // leading: GestureDetector(
      //   onTap: () => Navigator.of(context).pop(),
      //   child: Padding(
      //     padding: const EdgeInsets.only(left: 15.0, top: 10, bottom: 10),
      //     child: Container(
      //         // margin:
      //         //     const EdgeInsets.only(top: 5, bottom: 5),
      //         height: 40,
      //         width: 40,
      //         decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(10),
      //             color: CustomColors.blackBgColor.withOpacity(0.2)),
      //         child: Center(
      //           child: Icon(
      //             FontAwesomeIcons.arrowLeft,
      //             size: 18,
      //             color: CustomColors.whiteBgColor.withOpacity(0.4),
      //           ),
      //           // FaIcon(
      //           //   FontAwesomeIcons.message,
      //           //   size: 20,
      //           // ),
      //         )),
      //   ),
      // ),
      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.only(right: 15.0, top: 10, bottom: 10),
      //     child: Container(
      //         // margin:
      //         //     const EdgeInsets.only(top: 5, bottom: 5),
      //         height: 40,
      //         width: 40,
      //         decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(10),
      //             color: CustomColors.blackBgColor.withOpacity(0.2)),
      //         child: Center(
      //           child: Icon(
      //             FontAwesomeIcons.heart,
      //             size: 18,
      //             color: CustomColors.whiteBgColor.withOpacity(0.4),
      //           ),
      //           // FaIcon(
      //           //   FontAwesomeIcons.message,
      //           //   size: 20,
      //           // ),
      //         )),
      //   ),
      // Padding(
      //   padding: const EdgeInsets.only(right: 15.0, top: 10, bottom: 10),
      //   child: Container(
      //       // margin:
      //       //     const EdgeInsets.only(top: 5, bottom: 5),
      //       height: 40,
      //       width: 40,
      //       decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(10),
      //           color: CustomColors.blackBgColor.withOpacity(0.2)),
      //       child: Center(
      //         child: Icon(
      //           Icons.person_2_outlined,
      //           // size: 18,
      //           color: CustomColors.whiteBgColor.withOpacity(0.4),
      //         ),

      //         // ),
      //       )),
      // ),
      // ],
      // ),
      body: Container(
        color: mainColor.withOpacity(0.5),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Stack(
              children: [
                const Opacity(
                  opacity: 0.2,
                  child: SizedBox(
                    height: 260,
                    width: double.infinity,
                    child: Image(
                      image: AssetImage("assets/images/doodles.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpacer(MediaQuery.of(context).padding.top),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, top: 10, bottom: 10),
                            child: Container(
                                // margin:
                                //     const EdgeInsets.only(top: 5, bottom: 5),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: CustomColors.blackBgColor
                                        .withOpacity(0.2)),
                                child: Center(
                                  child: Icon(
                                    FontAwesomeIcons.arrowLeft,
                                    size: 18,
                                    color: CustomColors.whiteBgColor
                                        .withOpacity(0.4),
                                  ),
                                  // FaIcon(
                                  //   FontAwesomeIcons.message,
                                  //   size: 20,
                                  // ),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15.0, top: 10, bottom: 10),
                          child: Container(
                              // margin:
                              //     const EdgeInsets.only(top: 5, bottom: 5),
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: CustomColors.blackBgColor
                                      .withOpacity(0.2)),
                              child: Center(
                                child: Icon(
                                  FontAwesomeIcons.heart,
                                  size: 18,
                                  color: CustomColors.whiteBgColor
                                      .withOpacity(0.4),
                                ),
                                // FaIcon(
                                //   FontAwesomeIcons.message,
                                //   size: 20,
                                // ),
                              )),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: CustomColors.whiteBgColor,
                                    fontSize: 30),
                              ),
                              verticalSpacer(10),
                              Text(
                                "124 ActiveMembers",
                                style: TextStyle(
                                    color: CustomColors.whiteBgColor
                                        .withOpacity(0.7),
                                    fontSize: 15),
                              ),
                              verticalSpacer(20),
                              GestureDetector(
                                onTap: isMember
                                    ? () {
                                        Navigator.push(
                                          context,
                                          AnimatedBottomUpPageRoute(
                                            builder: (context) =>
                                                CreatePostScreen(
                                              mainColor: mainColor,
                                              discussions: discussions,
                                              communityId: communityId,
                                            ),
                                          ),
                                        );
                                        // showModalBottomSheet(
                                        //   enableDrag: false,
                                        //   isDismissible: false,
                                        //   isScrollControlled: true,
                                        //   backgroundColor: Colors.transparent,
                                        //   shape: const RoundedRectangleBorder(
                                        //       borderRadius: BorderRadius.vertical(
                                        //           top: Radius.circular(20))),
                                        //   context: context,
                                        //   builder: (context) =>
                                        //       buildStartDiscussionModal(
                                        //           mainColor));
                                      }
                                    : null,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: CustomColors.whiteBgColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 20),
                                    child: Text(
                                      isMember
                                          ? "Start a Discussion"
                                          : "Join Group",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: mainColor,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              GenericDialog().showSimplePopup(
                                type: InfoBoxType.error,
                                content: "This was successfull",
                              );
                            },
                            child: FaIcon(
                              icon,

                              // FontAwesomeIcons.heartPulse,
                              color: CustomColors.whiteBgColor.withOpacity(0.4),
                              size: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                    verticalSpacer(30),
                    Container(
                      height: MediaQuery.of(context).size.height * 2,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: CustomColors.whiteBgColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verticalSpacer(30),
                            const Text(
                              "About this group",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff5F5F5F),
                              ),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              maxLines: 2,
                            ),
                            verticalSpacer(10),
                            Text(
                              message,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff5F5F5F).withOpacity(0.8),
                              ),
                              maxLines: 5,
                              // overflow: TextOverflow.ellipsis,
                              // softWrap: false,
                              // maxLines: 2,
                            ),

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
                                      unselectedLabelColor: CustomColors
                                          .blackBgColor
                                          .withOpacity(0.4),
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
                                            color: CustomColors.mainBlueColor,
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

                            // TabBar(
                            //   isScrollable: true,
                            //   indicatorSize: TabBarIndicatorSize.label,
                            //   labelColor: CustomColors.blackColor,
                            //   unselectedLabelColor:
                            //       CustomColors.blackBgColor.withOpacity(0.4),
                            //   labelStyle: const TextStyle(
                            //     fontSize: 14,
                            //     fontWeight: FontWeight.w700,
                            //   ),
                            //   unselectedLabelStyle: const TextStyle(
                            //     fontSize: 14,
                            //     fontWeight: FontWeight.w700,
                            //   ),

                            //   indicator: BoxDecoration(
                            //     // borderRadius: BorderRadius.circular(10),
                            //     border: Border(
                            //       bottom: BorderSide(
                            //         color: mainColor,
                            //       ),
                            //     ),
                            //     color: Colors.transparent,
                            //   ),
                            //   controller:
                            //       _tabController, // Assign TabController to TabBar
                            //   tabs: const [
                            //     Tab(
                            //       text: 'Discussions',
                            //     ),
                            //   ],
                            // ),

                            verticalSpacer(20),
                            SizedBox(
                              height: 35,
                              // height: 30,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: discussions.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return activeIndex == index
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              activeIndex = -1;
                                              print(activeIndex);
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 12.0),
                                            child: Container(
                                              height: 20,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: mainColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12.0),
                                                child: Center(
                                                  child: Text(
                                                    "#${discussions[index]}   x",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: mainColor,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: false,
                                                    maxLines: 2,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              activeIndex = index;
                                              print(activeIndex);
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 12.0),
                                            child: Container(
                                              height: 20,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: mainColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12.0),
                                                child: Center(
                                                  child: Text(
                                                    "#${discussions[index]}",
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Color(0xff5F5F5F),
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: false,
                                                    maxLines: 2,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                },
                              ),
                            ),

                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: TabBarView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller:
                                      _tabController, // Assign TabController to TabBarView
                                  children: [
                                    CommunityDetailsFutureBuilder(
                                      ref: ref,
                                      fetchData:
                                          fetchallCommunityPosts(communityId),
                                      mainColor: mainColor,
                                    ),
                                    CommunityDetailsFutureBuilder(
                                      ref: ref,
                                      fetchData:
                                          fetchMyCommunityPosts(communityId),
                                      mainColor: mainColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Expanded(
                            //   // height: 30,
                            //   child: ListView.builder(
                            //     // scrollDirection: Axis.horizontal,
                            //     physics: const NeverScrollableScrollPhysics(),
                            //     shrinkWrap: true,
                            //     itemCount: discussions.length,
                            //     itemBuilder: (BuildContext context, int index) {
                            //       return CommunityPostContainer(mainColor: mainColor, activeIndex: activeIndex, discussions: discussions);
                            //     },
                            //   ),
                            // ),

                            verticalSpacer(30),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(vertical: 10.0),
                            //   child: TabBarView(
                            //     physics: const NeverScrollableScrollPhysics(),
                            //     controller: _tabController,
                            //     children: [
                            //       ListView.builder(
                            //         scrollDirection: Axis.horizontal,
                            //         shrinkWrap: true,
                            //         itemCount: 6,
                            //         itemBuilder: (BuildContext context, int index) {
                            //           return Padding(
                            //             padding: const EdgeInsets.only(right: 8.0),
                            //             child: Container(
                            //               width: 60,
                            //               height: 20,
                            //               decoration: BoxDecoration(
                            //                 border: Border.all(
                            //                   color: mainColor,
                            //                   width: 2.0,
                            //                 ),
                            //               ),
                            //             ),
                            //           );
                            //         },
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStartDiscussionModal(Color mainColor) {
    final userData = locator<LocalCache>().getUserData();
    // Navigator.of(context).pop()
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.7,
      minChildSize: 0.7,
      builder: (_, controller) => Container(
        height: 100,
        decoration: const BoxDecoration(
            color: CustomColors.whiteBgColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            // controller: controller,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: CustomColors.blackBgColor.withOpacity(0.2),
                            image: DecorationImage(
                                image: NetworkImage(userData.avatarUrl))),
                        // child: const Icon(Icons.person_2_outlined),
                      ),
                      horizontalSpacer(15),
                      Text(
                        "@${userData.userName}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff5F5F5F),
                        ),
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 2,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: FaIcon(
                      FontAwesomeIcons.xmark,

                      // FontAwesomeIcons.heartPulse,
                      color: CustomColors.blackIconColor.withOpacity(0.9),
                      size: 20,
                    ),
                  )
                ],
              ),
              verticalSpacer(20),
              customNoBorderTextField(
                'discuss',
                Icons.mail,
                null,
                'Start a Discussion .......',
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.email(
                        errorText: 'Provided email not valid '),
                    FormBuilderValidators.required(
                        errorText: 'Email field cannot be empty '),
                  ],
                ),
              ),
              verticalSpacer(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    // onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      height: 40,
                      width: 90,
                      decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: CustomColors.whiteColor,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CommunityPostContainer extends StatelessWidget {
  const CommunityPostContainer({
    super.key,
    required this.mainColor,
    required this.post,
    // required this.activeIndex,
    // required this.discussions,
  });

  final Color mainColor;
  final Post post;
  // final int activeIndex;
  // final List<String> discussions;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Container(
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
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  verticalSpacer(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // Padding(
                          //   padding:
                          //       const EdgeInsets.only(
                          //           right: 0),
                          //   child: Container(
                          //     height: 30,
                          //     width: 30,
                          //     decoration: BoxDecoration(
                          //         borderRadius:
                          //             BorderRadius
                          //                 .circular(
                          //                     10),
                          //         color: CustomColors
                          //             .mainBlueColor
                          //             .withOpacity(
                          //                 0.3)),
                          //     child: const Icon(
                          //         Icons
                          //             .person_2_outlined,
                          //         color: CustomColors
                          //             .mainBlueColor),
                          //   ),
                          // ),
                          // horizontalSpacer(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.userName,
                                // "Theresa",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: mainColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                maxLines: 2,
                              ),
                              Text(
                                "2 hours ago",
                                style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      const Color(0xff5F5F5F).withOpacity(0.7),
                                ),
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                maxLines: 2,
                              ),
                            ],
                          )
                        ],
                      ),
                      const FaIcon(
                        FontAwesomeIcons.bookmark,
                        color: CustomColors.greyBgColor,
                      ),
                    ],
                  ),
                  verticalSpacer(20),
                  const Text(
                    "How will I know if he is serious or just pass time?",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: CustomColors.blackBgColor,
                        fontSize: 20),
                  ),
                  verticalSpacer(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 23,
                            width: 23,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: CustomColors.mainBlueColor
                                    .withOpacity(0.4)),
                            child: const Center(
                                child: FaIcon(
                              FontAwesomeIcons.compass,
                              color: CustomColors.mainBlueColor,
                              size: 12,
                            )),
                          ),
                          horizontalSpacer(10),
                          Text(
                            post.categoryName,
                            // activeIndex == -1
                            //     ? "Long Distance"
                            //     : discussions[
                            //         activeIndex],
                            style: const TextStyle(
                              fontSize: 14,
                              color: CustomColors.mainBlueColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            maxLines: 2,
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: mainColor.withOpacity(0.1)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 8),
                          child: Text(
                            "42 Response(s)",
                            style: TextStyle(
                              fontSize: 14,
                              color: mainColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            maxLines: 2,
                          ),
                        ),
                      )
                    ],
                  ),
                  verticalSpacer(20),
                ],
              )),
        ),
      ),
    );
  }
}

class CommunityDetailsFutureBuilder extends StatelessWidget {
  const CommunityDetailsFutureBuilder({
    super.key,
    required this.ref,
    required this.fetchData,
    required this.mainColor,
  });

  final WidgetRef ref;
  final Future<List<Post>> fetchData;
  final Color mainColor;

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

          final posts = snapshot.data;

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
            child: ListView.builder(
              // scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: posts!.length,
              itemBuilder: (BuildContext context, int index) {
                return CommunityPostContainer(
                  mainColor: mainColor,
                  post: posts[index],
                );
              },
            ),
          );
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
            ],
          ),
        );
      },
    );
  }
}
