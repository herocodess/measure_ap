import 'package:flutter/material.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.baseColor,
    this.highlightColor,
    this.backgroundColor,
  });
  final double? height, width;
  final BorderRadiusGeometry? borderRadius;
  final Color? baseColor, highlightColor, backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.withOpacity(.1),
      highlightColor: highlightColor ?? AppColors.white60,
      child: Container(
        height: height ?? 35,
        margin: const EdgeInsets.only(top: 8),
        width: width ?? 150,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.normalGrey.withOpacity(.7),
          borderRadius: borderRadius ?? BorderRadius.circular(5),
        ),
      ),
    );
  }
}

class CustomShimmerLoading {
  static Widget patientCardShimmer(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
          2,
          (index) => Column(
            children: [
              Container(
                width: context.width,
                height: context.height * 0.2,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            width: context.width,
                            height: context.height * 0.05,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(30),
                              ),
                              color: AppColors.blue500.withOpacity(0.12),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomShimmer(),
                              ],
                            ),
                          ),
                        ),
                        const Expanded(
                          flex: 1,
                          child: CustomShimmer(
                            width: 5,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const CustomShimmer(),
                    SizedBox(
                      height: context.height * 0.01,
                    ),
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomShimmer(),
                        Spacer(),
                        CustomShimmer(),
                      ],
                    ),
                    SizedBox(
                      height: context.height * 0.01,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: context.height * 0.01,
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget recentAssessmentsShimmer(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
          2,
          (index) => Column(
            children: [
              Container(
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                          color: AppColors.orange400.withOpacity(0.12),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomShimmer(),
                          ],
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: CustomShimmer(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: context.height * 0.02,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
