import 'package:anon/models/confession_response_model.dart';
import 'package:anon/widgets/perspective_item_widget.dart';
import 'package:flutter/material.dart';

import '../screens/confessions/confession_detail_screen.dart';

class SlantedContainer extends StatefulWidget {
  final int index;
  final int currentVisibleItemIndex;
  final double scrolling;
  final ConfessionResponse confession;

  const SlantedContainer({
    Key? key,
    required this.index,
    required this.currentVisibleItemIndex,
    required this.scrolling,
    required this.confession,
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
        MaterialPageRoute(builder: (context) => const ConfessionDetailScreen()),
      );
    } else {
      _animationController.forward().whenComplete(() {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ConfessionDetailScreen()),
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
                          child: PerspectiveItem(
                              isCardActivated, widget.confession)));
                }),
          ),
        ));
  }
}
