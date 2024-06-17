import 'package:flutter/material.dart';

class TransparentPage<T> extends Page<T> {
  const TransparentPage({
    required this.child,
    this.transitionDuration = const Duration(milliseconds: 550),
    this.reverseTransitionDuration = const Duration(milliseconds: 550),
    this.maintainState = true,
    this.fullscreenDialog = true,
    this.opaque = false,
    this.barrierDismissible = true,
    this.barrierColor,
    this.barrierLabel,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  final Widget child;
  final Duration transitionDuration;
  final Duration reverseTransitionDuration;
  final bool maintainState;
  final bool fullscreenDialog;
  final bool opaque;
  final bool barrierDismissible;
  final Color? barrierColor;

  final String? barrierLabel;

  @override
  Route<T> createRoute(BuildContext context) =>
      _CustomTransitionPageRoute<T>(this);
}

class _CustomTransitionPageRoute<T> extends PageRoute<T> {
  _CustomTransitionPageRoute(TransparentPage<T> page) : super(settings: page);

  TransparentPage<T> get _page => settings as TransparentPage<T>;

  @override
  bool get barrierDismissible => _page.barrierDismissible;

  @override
  Color? get barrierColor => _page.barrierColor;

  @override
  String? get barrierLabel => _page.barrierLabel;

  @override
  Duration get transitionDuration => _page.transitionDuration;

  @override
  Duration get reverseTransitionDuration => _page.reverseTransitionDuration;

  @override
  bool get maintainState => _page.maintainState;

  @override
  bool get fullscreenDialog => _page.fullscreenDialog;

  @override
  bool get opaque => _page.opaque;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) =>
      Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        child: FadeTransition(
          opacity: animation,
          child: _page.child,
        ),
      );
}
