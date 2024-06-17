import 'package:flutter/material.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';

class AssessmentImageDialogWidget extends StatelessWidget {
  const AssessmentImageDialogWidget({super.key, required this.asset});
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Container(
        height: context.height * 0.3,
        decoration: const BoxDecoration(
          color: AppColors.whiteColor,
          shape: BoxShape.circle,
        ),
        margin: const EdgeInsets.all(30),
        child: Center(
          child: Image.asset(
            asset,
          ),
        ),
      ),
    );
  }
}
