// import 'package:anon/constants/custom_colors.dart';
// import 'package:anon/screens/confessions/confession_send_screen.dart';
// import 'package:anon/utils/spacers.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import '../../widgets/slanted_container.dart';
// import 'confession_view_model.dart';

// class ConfessionScreen extends StatefulHookConsumerWidget {
//   const ConfessionScreen({super.key});

//   @override
//   ConsumerState<ConfessionScreen> createState() => _ConfessionScreenState();
// }

// class _ConfessionScreenState extends ConsumerState<ConfessionScreen> {
//   int currentVisibleItemIndex = 0;
//   double scrolling = 0;

//   late ScrollController scrollController;

//   @override
//   void initState() {
//     scrollController = ScrollController();
//     scrollController.addListener(scrollListernerWithCount);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var screenHeight = MediaQuery.of(context).size.height;
//     var screenWidth = MediaQuery.of(context).size.width;
//     final confessionVM = ref.watch(confessionProvider);
//     return Scaffold(
//       backgroundColor: CustomColors.whiteBgColor,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 20.0,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             verticalSpacer(10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   "Confessions",
//                   style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       color: CustomColors.blackBgColor,
//                       fontSize: 30),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: ((context) =>
//                                 const ConfessionSendScreen())));
//                   },
//                   child: Container(
//                       // margin:
//                       //     const EdgeInsets.only(top: 5, bottom: 5),
//                       height: 40,
//                       width: 40,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: CustomColors.mainBlueColor.withOpacity(0.6)),
//                       child: const Center(
//                         child: Icon(
//                           FontAwesomeIcons.paperPlane,
//                           size: 18,
//                           color: CustomColors.whiteColor,
//                         ),
//                         // FaIcon(
//                         //   FontAwesomeIcons.message,
//                         //   size: 20,
//                         // ),
//                       )),
//                 ),
//               ],
//             ),
//             verticalSpacer(10),
//             Text(
//               "Get emotional advice, ask questions",
//               style: TextStyle(
//                   color: CustomColors.greyBgColor.withOpacity(0.7),
//                   fontSize: 15),
//             ),
//             verticalSpacer(20),
//             // verticalSpacer(25),

// //             Expanded(
// //               child: FutureBuilder(
// //                 future: Future.delayed(const Duration(seconds: 1)),
// //                 builder: (context, snapshot) {
// //                   if (snapshot.hasError) {
// //                     return Text('Error: ${snapshot.error}');
// //                   }

// //                   if (snapshot.connectionState == ConnectionState.waiting) {
// //                     return const CircularProgressIndicator();
// //                   }

// //                   if (!snapshot.hasData) {
// //                     final data = snapshot.data;
// // //TODO UNCOMMENT HERE

// //                     return ListView.builder(
// //                       itemCount: 10,
// //                       controller: scrollController,
// //                       itemBuilder: (context, index) {
// //                         return SlantedContainer(
// //                             index: index,
// //                             currentVisibleItemIndex: currentVisibleItemIndex,
// //                             scrolling: scrolling);
// //                       },
// //                     );
// //                     // return Text('Received data: $data');
// //                   }

// //                   return const Text('No data available');
// //                 },
// //               ),
// //             ),

//             //Second Important
// //             Expanded(
// //               child: Builder(builder: (context) {
// //                 return StreamBuilder(
// //                   stream: ConfessionViewModel.initWhoAmI().getAllConfessions(),
// //                   builder: (context, snapshot) {
// //                     if (snapshot.hasError) {
// //                       return Text('Error: ${snapshot.error}');
// //                     }

// //                     if (snapshot.connectionState == ConnectionState.waiting) {
// //                       return const CircularProgressIndicator();
// //                     }

// //                     if (snapshot.hasData) {
// //                       final data = snapshot.data;
// // //TODO UNCOMMENT HERE
// //                       // if (snapshot.data!.docs.isEmpty) {
// //                       //   return Center(
// //                       //     child: Column(
// //                       //       mainAxisAlignment: MainAxisAlignment.center,
// //                       //       children: [
// //                       //         Lottie.asset(
// //                       //           "assets/animations/no-transaction-history.json",
// //                       //           height: 150,
// //                       //           width: 150,
// //                       //           animate: true,
// //                       //           repeat: true,
// //                       //           reverse: false,
// //                       //           fit: BoxFit.contain,
// //                       //         ),
// //                       //         verticalSpacer(20),
// //                       //         Text(
// //                       //           "You have no  confessions available at the moment, share link below",
// //                       //           textAlign: TextAlign.center,
// //                       //           style: TextStyle(
// //                       //               color:
// //                       //                   CustomColors.greyBgColor.withOpacity(0.7),
// //                       //               fontSize: 15),
// //                       //         ),
// //                       //       ],
// //                       //     ),
// //                       //   );
// //                       // }
// //                       return ListView.builder(
// //                         itemCount: 10,
// //                         controller: scrollController,
// //                         itemBuilder: (context, index) {
// //                           return SlantedContainer(
// //                               index: index,
// //                               currentVisibleItemIndex: currentVisibleItemIndex,
// //                               scrolling: scrolling);
// //                         },
// //                       );
// //                       // return Text('Received data: $data');
// //                     }

// //                     return const Text('No data available');
// //                   },
// //                 );
// //               }),
// //             ),
//             FutureBuilder(
//                 future: Future.delayed(const Duration(seconds: 1)),
//                 builder: (context, snapshot) {
//                   return Expanded(
//                     child: ListView.builder(
//                       itemCount: 10,
//                       controller: scrollController,
//                       itemBuilder: (context, index) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return const CircularProgressIndicator();
//                         }
//                         return SlantedContainer(
//                             index: index,
//                             currentVisibleItemIndex: currentVisibleItemIndex,
//                             scrolling: scrolling);
//                         // return PerspectiveWidgetx(
//                         //     index, currentVisibleItemIndex, scrolling);
//                       },
//                     ),
//                   );
//                 })

// // This is my Important code oo
//             // Expanded(
//             //   child: ListView.builder(
//             //     itemCount: 10,
//             //     controller: scrollController,
//             //     itemBuilder: (context, index) {
//             //       return SlantedContainer(
//             //           index: index,
//             //           currentVisibleItemIndex: currentVisibleItemIndex,
//             //           scrolling: scrolling);
//             //       // return PerspectiveWidgetx(
//             //       //     index, currentVisibleItemIndex, scrolling);
//             //     },
//             //   ),
//             // )
//           ],
//         ),
//       ),
//     );
//   }

//   //Here we detect the first visible item and then change the scale of the item
//   void scrollListernerWithCount() {
//     int itemCount = 10;
//     double scrollOffset = scrollController.position.pixels;
//     double viewportHeight = scrollController.position.viewportDimension;
//     double scrollRange = scrollController.position.maxScrollExtent -
//         scrollController.position.minScrollExtent;
//     int firstVisibleItemIndex =
//         (scrollOffset / (scrollRange + viewportHeight) * itemCount).floor();
//     currentVisibleItemIndex = firstVisibleItemIndex;
//     scrolling = (scrollOffset / (scrollRange + viewportHeight) * itemCount);
//     scrolling = double.parse(scrolling.toStringAsFixed(2));
//     setState(() {
//       print(firstVisibleItemIndex);
//     });
//   }
// }

// class PerspectiveWidgetx extends StatelessWidget {
//   PerspectiveWidgetx(
//     this.index,
//     this.currentVisibleItemIndex,
//     this.scrolling, {
//     super.key,
//   });

//   int index;
//   int currentVisibleItemIndex;
//   double scrolling;

//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;

//     double scale = 0.85;
//     bool isCardActivated = false;
//     int upcomingWidgetIndex = scrolling.floor() + 1;
//     if (scrolling > (currentVisibleItemIndex + 0.3)) {
//       if (scrolling > 0 && index == upcomingWidgetIndex) {
//         scale = 1;
//       }
//     } else if (index == currentVisibleItemIndex) {
//       scale = 1;
//     } else {
//       // if (currentVisibleItemIndex != 0) scale = 0.85;
//       scale = 0.85;
//     }

//     isCardActivated = scale == 1 ? true : false;

//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10.0),
//       child: AnimatedScale(
//         duration: const Duration(milliseconds: 200),
//         scale: scale,
//         //index == currentVisibleItemIndex ? 1 : 0.94,
//         child: Transform(
//             transform: Matrix4.identity()
//               ..setEntry(3, 2, -0.004)
//               ..rotateX(0.24),
//             alignment: Alignment.center,
//             child: Align(
//                 // heightFactor: 0.78,
//                 alignment: Alignment.topCenter,
//                 child: PerspectiveItem(isCardActivated))),
//       ),
//     );

//     // return Padding(
//     //   padding: const EdgeInsets.only(bottom: 10.0),
//     //   child: AnimatedScale(
//     //     duration: const Duration(milliseconds: 200),
//     //     scale: scale,
//     //     //index == currentVisibleItemIndex ? 1 : 0.94,
//     //     child: Transform(
//     //         transform: Matrix4.identity()
//     //           ..setEntry(3, 2, -0.004)
//     //           ..rotateX(0.24),
//     //         alignment: Alignment.center,
//     //         child: Align(
//     //             // heightFactor: 0.78,
//     //             alignment: Alignment.topCenter,
//     //             child: PerspectiveItem(isCardActivated))),
//     //   ),
//     // );
//   }
// }

// class PerspectiveItem extends StatelessWidget {
//   PerspectiveItem(
//     this.isCardActivated, {
//     super.key,
//   });
//   bool isCardActivated;
//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;

//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         //Shadow Widget
//         Container(
//           height: 250,
//           width: 150,
//           decoration: BoxDecoration(
//               color: CustomColors.whiteColor,
//               borderRadius: const BorderRadius.all(Radius.circular(40)),
//               boxShadow: [
//                 BoxShadow(
//                   color: const Color(0xFF1059C6).withOpacity(0.15),
//                   blurRadius: 50,
//                   spreadRadius: 10,
//                   offset: const Offset(0, 40),
//                 )
//               ]),
//         ),

//         // Real card widget
//         Container(
//           height: 250,
//           width: screenWidth * 0.75,
//           decoration: const BoxDecoration(
//             color: CustomColors.whiteColor,
//             borderRadius: BorderRadius.all(Radius.circular(60)),
//             // boxShadow: [
//             //   BoxShadow(
//             //     color:
//             //         const Color(0xFF1059C6).withOpacity(0.15),
//             //     blurRadius: 50,
//             //     spreadRadius: 10,
//             //     offset: const Offset(0, 40),
//             //   )
//             // ]
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child:
//                 Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//               Container(
//                 height: 45,
//                 width: 45,
//                 decoration: const BoxDecoration(
//                     shape: BoxShape.circle, color: CustomColors.mainBlueColor),
//                 child: const Icon(Icons.person_2_outlined),
//               ),
//               verticalSpacer(10),
//               Text(
//                 "@elvis",
//                 style: TextStyle(
//                     fontSize: 11,
//                     // fontWeight: FontWeight.w400,
//                     color: Colors.grey.shade500),
//               ),
//               verticalSpacer(15),
//               const Text(
//                 "Had a bad day at the gym, I'm wheezing",
//                 style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
//               ),
//               verticalSpacer(15),
//               const Text(
//                 "Unlimited cards and spaces, investments tips and much more more more more more more more more more more more more more more more more more",
//                 textAlign: TextAlign.center,
//                 maxLines: 3,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                     fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),
//               ),
//               // verticalSpacer(10),
//               // Text(
//               //   "read all features",
//               //   style: TextStyle(
//               //       fontSize: 11,
//               //       // fontWeight: FontWeight.w400,
//               //       color: Colors.grey.shade500),
//               // ),
//               verticalSpacer(10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   // Text(
//                   //   "I want this",
//                   //   style: TextStyle(
//                   //       fontSize: 12,
//                   //       fontWeight: FontWeight.w600,
//                   //       color: isCardActivated
//                   //           ? Colors.greenAccent
//                   //           : Colors.grey.shade500),
//                   // ),
//                   Container(
//                       // margin:
//                       //     const EdgeInsets.only(top: 5, bottom: 5),
//                       height: 30,
//                       width: 30,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: isCardActivated
//                               ? CustomColors.mainBlueColor.withOpacity(0.6)
//                               : Colors.grey.shade500),
//                       child: const Center(
//                         child: Icon(
//                           FontAwesomeIcons.star,
//                           size: 16,
//                           color: CustomColors.whiteColor,
//                         ),
//                         // FaIcon(
//                         //   FontAwesomeIcons.message,
//                         //   size: 20,
//                         // ),
//                       )),
//                   horizontalSpacer(20),
//                   Container(
//                       // margin:
//                       //     const EdgeInsets.only(top: 5, bottom: 5),
//                       height: 30,
//                       width: 30,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: isCardActivated
//                               ? CustomColors.mainBlueColor.withOpacity(0.6)
//                               : Colors.grey.shade500),
//                       child: const Center(
//                         child: Icon(
//                           Icons.message,
//                           size: 16,
//                           color: CustomColors.whiteColor,
//                         ),
//                         // FaIcon(
//                         //   FontAwesomeIcons.message,
//                         //   size: 20,
//                         // ),
//                       )),
//                   horizontalSpacer(20),
//                   Container(
//                       // margin:
//                       //     const EdgeInsets.only(top: 5, bottom: 5),
//                       height: 30,
//                       width: 30,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: isCardActivated
//                               ? CustomColors.mainBlueColor.withOpacity(0.6)
//                               : Colors.grey.shade500),
//                       child: const Center(
//                         child: Icon(
//                           FontAwesomeIcons.camera,
//                           size: 16,
//                           color: CustomColors.whiteColor,
//                         ),
//                         // FaIcon(
//                         //   FontAwesomeIcons.message,
//                         //   size: 20,
//                         // ),
//                       )),
//                   horizontalSpacer(20),
//                 ],
//               ),
//             ]),
//           ),
//         ),
//       ],
//     );
//   }
// }
