import 'package:anon/utils/spacers.dart';
import 'package:flutter/material.dart';

class AnimatedContainerFromTop extends StatefulWidget {
  const AnimatedContainerFromTop({super.key});

  @override
  _AnimatedContainerFromTopState createState() =>
      _AnimatedContainerFromTopState();
}

class _AnimatedContainerFromTopState extends State<AnimatedContainerFromTop>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  double _offset = 0.0;

  @override
  void initState() {
    super.initState();

    // Create animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Create tween
    final Tween<Offset> tween = Tween(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    );

    // Create curved animation
    final CurvedAnimation curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);

    // Create animation
    _animation = tween.animate(curvedAnimation);

    // Start animation
    _controller.forward();
  }

  @override
  void dispose() {
    // Dispose animation controller
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            setState(() {
              // Update offset based on drag direction and distance
              _offset += details.delta.dy;
              if (_offset < 0) {
                _offset = 0;
              } else if (_offset > MediaQuery.of(context).size.height - 200) {
                _offset = MediaQuery.of(context).size.height - 200;
              }
            });
          },
          child: Stack(
            children: [
              const Center(
                child: Text("Scroll up or down to change the position"),
              ),
              Positioned(
                top: _offset,
                left: 0,
                right: 0,
                child: SlideTransition(
                  position: _animation,
                  child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
