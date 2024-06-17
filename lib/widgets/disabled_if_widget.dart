import 'package:flutter/material.dart';

class DisabledIfWidget extends StatelessWidget {
  const DisabledIfWidget(
      {super.key, required this.child, required this.condition});
  final Widget child;
  final bool condition;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: condition,
      child: Opacity(
        opacity: condition ? .5 : 1,
        child: child,
      ),
    );
  }
}
