import 'package:flutter/material.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/core/utils/images.dart';
import 'package:kochanet_measure_app/core/utils/styles.dart';

class RowWithCircleDotSpacer extends StatelessWidget {
  const RowWithCircleDotSpacer(
      {super.key, required this.text, this.isLast = false});
  final String text;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: AppStyles.w700Style(14, AppColors.grey600),
        ),
        isLast
            ? const SizedBox.shrink()
            : SizedBox(
                width: context.width * 0.015,
              ),
        isLast
            ? const SizedBox.shrink()
            : Image.asset(
                AppImages.circleDotImg,
                scale: 2.2,
              ),
        isLast
            ? const SizedBox.shrink()
            : SizedBox(
                width: context.width * 0.015,
              ),
      ],
    );
  }
}
