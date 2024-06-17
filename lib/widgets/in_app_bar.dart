import 'package:flutter/material.dart';
import 'package:kochanet_measure_app/core/router/navigation_service.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/styles.dart';

class InAppBar extends StatelessWidget {
  const InAppBar({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            size: 14,
            color: AppColors.black600,
          ),
        ),
        const Spacer(),
        Text(
          text,
          style: AppStyles.w800Style(16, AppColors.black600),
        ),
        const Spacer(),
        Container(),
      ],
    );
  }
}
