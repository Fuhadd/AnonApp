import 'package:anon/constants/custom_colors.dart';
import 'package:anon/utils/spacers.dart';
import 'package:flutter/material.dart';

import '../../screens/onboarding/onboarding_page_view.dart';

class StackedCardScreen extends StatefulWidget {
  const StackedCardScreen({super.key});

  @override
  State<StackedCardScreen> createState() => _StackedCardScreenState();
}

class _StackedCardScreenState extends State<StackedCardScreen> {
  int currentVisibleItemIndex = 0;
  double scrolling = 0;

  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(scrollListernerWithCount);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: CustomColors.whiteBgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Choose",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
            ),
            verticalSpacer(5),
            const Text(
              "Your Plan",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
            ),
            verticalSpacer(15),
            const Text(
              "You can always start with a",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            verticalSpacer(2),
            const Text(
              "free plan and then upgrade",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            ),
            verticalSpacer(25),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                controller: scrollController,
                itemBuilder: (context, index) {
                  return SlantedContainer(
                      index: index,
                      currentVisibleItemIndex: currentVisibleItemIndex,
                      scrolling: scrolling);
                  // return PerspectiveWidgetx(
                  //     index, currentVisibleItemIndex, scrolling);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  //Here we detect the first visible item and then change the scale of the item
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

class PerspectiveWidgetx extends StatelessWidget {
  PerspectiveWidgetx(
    this.index,
    this.currentVisibleItemIndex,
    this.scrolling, {
    super.key,
  });

  int index;
  int currentVisibleItemIndex;
  double scrolling;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    double scale = 0.85;
    bool isCardActivated = false;
    int upcomingWidgetIndex = scrolling.floor() + 1;
    if (scrolling > (currentVisibleItemIndex + 0.3)) {
      if (scrolling > 0 && index == upcomingWidgetIndex) {
        scale = 1;
      }
    } else if (index == currentVisibleItemIndex) {
      scale = 1;
    } else {
      // if (currentVisibleItemIndex != 0) scale = 0.85;
      scale = 0.85;
    }

    isCardActivated = scale == 1 ? true : false;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        scale: scale,
        //index == currentVisibleItemIndex ? 1 : 0.94,
        child: Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, -0.004)
              ..rotateX(0.24),
            alignment: Alignment.center,
            child: Align(
                // heightFactor: 0.78,
                alignment: Alignment.topCenter,
                child: PerspectiveItem(isCardActivated))),
      ),
    );

    // return Padding(
    //   padding: const EdgeInsets.only(bottom: 10.0),
    //   child: AnimatedScale(
    //     duration: const Duration(milliseconds: 200),
    //     scale: scale,
    //     //index == currentVisibleItemIndex ? 1 : 0.94,
    //     child: Transform(
    //         transform: Matrix4.identity()
    //           ..setEntry(3, 2, -0.004)
    //           ..rotateX(0.24),
    //         alignment: Alignment.center,
    //         child: Align(
    //             // heightFactor: 0.78,
    //             alignment: Alignment.topCenter,
    //             child: PerspectiveItem(isCardActivated))),
    //   ),
    // );
  }
}

class PerspectiveItem extends StatelessWidget {
  PerspectiveItem(
    this.isCardActivated, {
    super.key,
  });
  bool isCardActivated;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      alignment: Alignment.center,
      children: [
        //Shadow Widget
        Container(
          height: 230,
          width: 150,
          decoration: BoxDecoration(
              color: CustomColors.whiteColor,
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1059C6).withOpacity(0.15),
                  blurRadius: 50,
                  spreadRadius: 10,
                  offset: const Offset(0, 40),
                )
              ]),
        ),

        // Real card widget
        Container(
          height: 230,
          width: screenWidth * 0.7,
          decoration: const BoxDecoration(
            color: CustomColors.whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(60)),
            // boxShadow: [
            //   BoxShadow(
            //     color:
            //         const Color(0xFF1059C6).withOpacity(0.15),
            //     blurRadius: 50,
            //     spreadRadius: 10,
            //     offset: const Offset(0, 40),
            //   )
            // ]
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              "noWhite",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            verticalSpacer(5),
            Text(
              "4.00\$ monthly",
              style: TextStyle(
                  fontSize: 11,
                  // fontWeight: FontWeight.w400,
                  color: Colors.grey.shade500),
            ),
            verticalSpacer(20),
            const Text(
              "Unlimited cards and spaces, \ninvestments tips and much more",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w500, height: 1.3),
            ),
            verticalSpacer(10),
            Text(
              "read all features",
              style: TextStyle(
                  fontSize: 11,
                  // fontWeight: FontWeight.w400,
                  color: Colors.grey.shade500),
            ),
            verticalSpacer(10),
            Text(
              "I want this",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isCardActivated
                      ? Colors.greenAccent
                      : Colors.grey.shade500),
            ),
          ]),
        ),
      ],
    );
  }
}

// class SlantedContainer extends StatefulWidget {
//   final int index;
//   final int currentVisibleItemIndex;
//   final double scrolling;

//   const SlantedContainer({
//     Key? key,
//     required this.index,
//     required this.currentVisibleItemIndex,
//     required this.scrolling,
//   }) : super(key: key);

//   @override
//   _SlantedContainerState createState() => _SlantedContainerState();
// }

// class _SlantedContainerState extends State<SlantedContainer>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;

//   double _scale = 1.0;
//   double _rotationX = 0.24;

//   bool _isAnimationCompleted = false;
//   bool isCardActivated = false;

//   @override
//   void initState() {
//     super.initState();

//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 200),
//       vsync: this,
//     );

//     _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
//       ..addListener(() {
//         setState(() {
//           _scale = 1.0 + (_animation.value * 0.06);
//           _rotationX = 0.24 - (_animation.value * 0.24);
//         });
//       })
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           setState(() {
//             _isAnimationCompleted = true;
//           });
//         }
//       });
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void _handleTap() {
//     if (_animationController.status == AnimationStatus.completed) {
//       _navigateToNewScreen();
//     } else {
//       _animationController.forward();
//     }
//   }

//   void _navigateToNewScreen() {
//     // Perform navigation to the new screen here
//     // You can use Navigator.push or any other navigation method
//     // Example:
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const OnboardingPageViewScreen()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _handleTap,
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 10.0),
//         child: AnimatedBuilder(
//           animation: _animation,
//           builder: (context, child) {
//             return Transform(
//               transform: Matrix4.identity()
//                 ..setEntry(3, 2, -0.004)
//                 ..rotateX(_rotationX),
//               alignment: Alignment.center,
//               child: Align(
//                 alignment: Alignment.topCenter,
//                 child: Transform.scale(
//                   scale: _scale,
//                   child: child,
//                 ),
//               ),
//             );
//           },
//           child: PerspectiveItem(isCardActivated),
//         ),
//       ),
//     );
//   }
// }

class SlantedContainer extends StatefulWidget {
  final int index;
  final int currentVisibleItemIndex;
  final double scrolling;

  const SlantedContainer({
    Key? key,
    required this.index,
    required this.currentVisibleItemIndex,
    required this.scrolling,
  }) : super(key: key);

  @override
  _SlantedContainerState createState() => _SlantedContainerState();
}

class _SlantedContainerState extends State<SlantedContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  double _scale = 1.0;
  double _rotationX = 0.24;
  bool _isAnimationCompleted = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {
          // Update the scale and rotationX values based on the animation value
          _scale = 1.0 + (_animation.value * 0.06);
          // _rotationX = _animation.value * 0.24;
          _rotationX = _animation.value * 0;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _isAnimationCompleted = true;
          });
        }
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (_animationController.status == AnimationStatus.completed) {
      // _animationController.reverse();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const OnboardingPageViewScreen()),
      );
    } else {
      _animationController.forward().whenComplete(() {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const OnboardingPageViewScreen()),
        );
      });
    }
  }

  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    double scale = 0.85;
    bool isCardActivated = false;
    int upcomingWidgetIndex = widget.scrolling.floor() + 1;
    if (widget.scrolling > (widget.currentVisibleItemIndex + 0.3)) {
      if (widget.scrolling > 0 && widget.index == upcomingWidgetIndex) {
        scale = 1;
      }
    } else if (widget.index == widget.currentVisibleItemIndex) {
      scale = 1;
    } else {
      // if (currentVisibleItemIndex != 0) scale = 0.85;
      scale = 0.85;
    }

    isCardActivated = scale == 1 ? true : false;
    return GestureDetector(
        onTap: scale == 1 ? _handleTap : null,
        // onTap: () {
        //   setState(() {
        //     isPressed = true;
        //   });
        // },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: scale,
            //index == currentVisibleItemIndex ? 1 : 0.94,
            child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, -0.004)
                        ..rotateX(_rotationX),
                      alignment: Alignment.center,
                      child: Align(
                          // heightFactor: 0.78,
                          alignment: Alignment.topCenter,
                          child: PerspectiveItem(isCardActivated)));
                }),
          ),
        )

        //  Padding(
        //   padding: const EdgeInsets.only(bottom: 10.0),
        //   child: AnimatedBuilder(
        //     animation: _animation,
        //     builder: (context, child) {
        //       return Transform(
        //         transform: Matrix4.identity()
        //           ..setEntry(3, 2, -0.004)
        //           ..rotateX(_rotationX),
        //         alignment: Alignment.center,
        //         child: Align(
        //           alignment: Alignment.topCenter,
        //           child: Transform.scale(
        //             scale: scale,
        //             child: child,
        //           ),
        //         ),
        //       );
        //     },
        //     child: PerspectiveItem(isCardActivated),
        //   ),
        // ),
        );
  }
}
