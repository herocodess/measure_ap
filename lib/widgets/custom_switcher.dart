import 'package:flutter/material.dart';

class CustomSwitcher extends StatelessWidget {
  const CustomSwitcher({
    super.key,
    required this.state,
    required this.firstChild,
    this.secondChild = const SizedBox.shrink(),
    this.duration = const Duration(milliseconds: 400),
  });
  final bool state;
  final Widget firstChild;
  final Widget secondChild;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child: state ? firstChild : secondChild,
    );
  }
}
