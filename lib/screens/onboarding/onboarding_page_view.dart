import 'package:anon/screens/auth/auth_screens.dart';
import 'package:anon/screens/onboarding/second_onboarding_page.dart';
import 'package:anon/utils/enum.dart';
import 'package:anon/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../constants/custom_colors.dart';
import '../../utils/spacers.dart';
import 'first_onboarding_page.dart';
import 'third_onboarding_page.dart';

class OnboardingPageViewScreen extends StatefulWidget {
  static const routeName = '/OnboardingPageViewScreen';
  const OnboardingPageViewScreen({super.key});

  @override
  State<OnboardingPageViewScreen> createState() =>
      _OnboardingPageViewScreenState();
}

class _OnboardingPageViewScreenState extends State<OnboardingPageViewScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteBgColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpacer(20),
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/anon_icon.png"),
                        fit: BoxFit.cover)),
              ),

              Expanded(
                child: PageView(
                  // physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: const [
                    FirstOnboardingPage(),
                    SecondOnboardingPage(),
                    ThirdOnboardingPage(),
                  ],
                ),
              ),

              verticalSpacer(30),
              SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: const ExpandingDotsEffect(
                    activeDotColor: CustomColors.blackBgColor,
                    dotColor: CustomColors.greyTextColor,
                    dotHeight: 5,
                    dotWidth: 20,
                    spacing: 5,
                    expansionFactor: 1.5,
                    strokeWidth: 100),
              ),
              verticalSpacer(35),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                        title: "Register",
                        color: CustomColors.mainBlueColor,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AuthScreen(
                                authType: AuthType.signUp,
                              ),
                            ),
                          );
                        }),
                  ),
                  horizontalSpacer(15),
                  Expanded(
                    child: CustomButton(
                        title: "Login",
                        hasBorder: true,
                        color: Colors.transparent,
                        borderColor: CustomColors.greyBgColor,
                        textcolor: CustomColors.greyBgColor,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AuthScreen(
                                authType: AuthType.signIn,
                              ),
                            ),
                          );
                        }),
                  ),
                  horizontalSpacer(90)
                ],
              ),
              verticalSpacer(90),

              // Padding(
              //   padding: const EdgeInsets.only(bottom: 40.0),
              //   child: Column(
              //     children: [
              //       GestureDetector(
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(horizontal: 32),
              //           child: Center(
              //             child: Container(
              //               width: double.infinity,
              //               padding: const EdgeInsets.symmetric(horizontal: 60),
              //               decoration: BoxDecoration(
              //                 color: CustomColors.mainPinkColor,
              //                 borderRadius: BorderRadius.circular(20),
              //               ),
              //               child: TextButton(
              //                   onPressed: () async {
              //                     //   Navigator.push(
              //                     //       context,
              //                     //       MaterialPageRoute(
              //                     //           builder: (context) =>
              //                     //               const SignupEmailScreen()));
              //                   },
              //                   child: const Text("Create Account",
              //                       style: TextStyle(
              //                           color: Colors.white,
              //                           fontSize: 18,
              //                           fontWeight: FontWeight.w700))),
              //             ),
              //           ),
              //         ),
              //       ),
              //       verticalSpacer(30),
              //       GestureDetector(
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(horizontal: 32),
              //           child: Center(
              //             child: Container(
              //               width: double.infinity,
              //               padding: const EdgeInsets.symmetric(horizontal: 60),
              //               decoration: BoxDecoration(
              //                 color: CustomColors.whiteColor,
              //                 borderRadius: BorderRadius.circular(20),
              //               ),
              //               child: TextButton(
              //                   onPressed: () async {
              //                     // Navigator.push(
              //                     //     context,
              //                     //     MaterialPageRoute(
              //                     //         builder: (context) =>
              //                     //             SigninScreen()));
              //                   },
              //                   child: const Text("SIGN IN",
              //                       style: TextStyle(
              //                           color: CustomColors.mainPurpleColor,
              //                           fontSize: 18,
              //                           fontWeight: FontWeight.w700))),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedPageIndicator extends StatefulWidget {
  final int pageCount;
  final double dotSize;
  final double indicatorRadius;
  final Color activeColor;
  final Color inactiveColor;

  const AnimatedPageIndicator({
    Key? key,
    required this.pageCount,
    this.dotSize = 10.0,
    this.indicatorRadius = 30.0,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
  }) : super(key: key);

  @override
  _AnimatedPageIndicatorState createState() => _AnimatedPageIndicatorState();
}

class _AnimatedPageIndicatorState extends State<AnimatedPageIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation =
        Tween<double>(begin: 0, end: widget.pageCount - 1).animate(_controller)
          ..addListener(() {
            setState(() {
              _currentPage = _animation.value.toInt();
            });
          });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.pageCount, (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: widget.dotSize,
                height: widget.dotSize,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? widget.activeColor
                        : widget.inactiveColor,
                  ),
                ),
              ),
            );
          }),
        ),
        Positioned(
          left: (_currentPage * (widget.dotSize * 2 + 16)) +
              widget.dotSize +
              (widget.dotSize / 2),
          top: 0,
          bottom: 0,
          child: SizedBox(
            width: widget.indicatorRadius,
            height: widget.indicatorRadius,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.activeColor,
                boxShadow: [
                  BoxShadow(
                    color: widget.activeColor.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void goToPage(int page) {
    _controller.animateTo(
      page.toDouble(),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
