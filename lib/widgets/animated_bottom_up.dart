import 'package:flutter/material.dart';

class AnimatedBottomUpPageRoute<T> extends PageRouteBuilder<T> {
  final WidgetBuilder builder;

  AnimatedBottomUpPageRoute({required this.builder})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return builder(context);
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
}
