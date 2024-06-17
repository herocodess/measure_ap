// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/core/utils/images.dart';
import 'package:kochanet_measure_app/core/utils/styles.dart';

class CustomLoader extends StatefulWidget {
  final bool hasText;
  const CustomLoader({
    super.key,
    this.hasText = false,
  });

  @override
  _CustomLoaderState createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  var tween = Tween<double>(begin: 0, end: 1)
    ..chain(CurveTween(curve: Curves.ease));

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..forward()
          ..repeat(reverse: false);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: context.width,
        height: context.height,
        color: AppColors.whiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationTransition(
              turns: animationController!.drive(tween),
              child: Center(
                child: Image.asset(
                  AppImages.loadingLogo,
                  scale: 1.9,
                ),
              ),
            ),
            SizedBox(
              height: context.height * 0.005,
            ),
            if (widget.hasText == true)
              Text(
                'Loading assessment',
                style: AppStyles.w800Style(16, AppColors.black600),
              ),
          ],
        ),
      ),
    );
  }
}
