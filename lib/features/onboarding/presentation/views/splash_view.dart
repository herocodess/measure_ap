import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:kochanet_measure_app/core/router/app_routes.dart';
import 'package:kochanet_measure_app/core/router/navigation_service.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/core/utils/styles.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () async {
      pushToAndClearStack(context, AppRoutes.home.path);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          context.l10n.appName,
          style: AppStyles.w800Style(40, AppColors.black600),
        )
            .animate(onPlay: (controller) => controller.repeat())
            .shimmer(duration: 1500.ms, color: AppColors.animationColor)
            .animate()
            .fadeIn(duration: 1500.ms, curve: Curves.easeInQuad)
            .slide(),
      ),
    );
  }
}
