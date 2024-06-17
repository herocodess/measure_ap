import 'package:flutter/material.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/core/utils/images.dart';
import 'package:kochanet_measure_app/core/utils/styles.dart';

class RecentAssessmentsCard extends StatelessWidget {
  const RecentAssessmentsCard({
    super.key,
    required this.onTap,
    required this.cognitiveStatus,
    required this.applicableMeasures,
  });
  final Function()? onTap;
  final String cognitiveStatus;
  final String applicableMeasures;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: context.width,
        height: context.height * 0.07,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withOpacity(0.15),
              offset: const Offset(0, 21),
              blurRadius: 18.8,
              spreadRadius: -19,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                width: context.width,
                height: context.height * 0.05,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                  color: AppColors.orange400.withOpacity(0.12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      cognitiveStatus.toUpperCase(),
                      style: AppStyles.w800Style(14, AppColors.orange600),
                    ),
                    SizedBox(
                      width: context.width * 0.015,
                    ),
                    Image.asset(
                      AppImages.circleDotImg,
                      scale: 2.2,
                      color: AppColors.orange600,
                    ),
                    SizedBox(
                      width: context.width * 0.015,
                    ),
                    Text(
                      applicableMeasures.toUpperCase(),
                      style: AppStyles.w500Style(14, AppColors.orange600),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Image.asset(
                AppImages.lineCirleImg,
                scale: 1.4,
                color: AppColors.orange600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
