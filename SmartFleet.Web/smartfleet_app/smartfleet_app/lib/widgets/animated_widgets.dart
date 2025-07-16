import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// ويدجت للانيميشن المنزلق من اليسار
class SlideInAnimation extends StatelessWidget {
  final Widget child;
  final int index;
  final int delay;

  const SlideInAnimation({
    Key? key,
    required this.child,
    this.index = 0,
    this.delay = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      delay: Duration(milliseconds: delay),
      child: SlideAnimation(
        verticalOffset: 50.0,
        horizontalOffset: -50.0,
        child: FadeInAnimation(
          child: child,
        ),
      ),
    );
  }
}

// ويدجت للانيميشن التدريجي للقوائم
class StaggeredListAnimation extends StatelessWidget {
  final Widget child;
  final int index;

  const StaggeredListAnimation({
    Key? key,
    required this.child,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: child,
        ),
      ),
    );
  }
} 