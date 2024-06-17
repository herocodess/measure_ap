import 'package:flutter/material.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/core/utils/images.dart';
import 'package:kochanet_measure_app/core/utils/styles.dart';

class SeeMoreWidget extends StatelessWidget {
  const SeeMoreWidget({super.key, required this.onTap});
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.l10n.seeMore,
            style: AppStyles.w700Style(12, AppColors.grey600),
          ),
          SizedBox(
            width: context.width * 0.007,
          ),
          Image.asset(
            AppImages.arrowRightImg,
            scale: 1.7,
          ),
        ],
      ),
    );
  }
}
