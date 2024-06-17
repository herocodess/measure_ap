import 'package:flutter/material.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/core/utils/styles.dart';

class AppBarTextItemWidget extends StatelessWidget {
  const AppBarTextItemWidget({
    super.key,
    required this.text1,
    required this.text2,
  });

  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          style: AppStyles.w500Style(12, AppColors.grey600),
        ),
        SizedBox(
          height: context.height * 0.003,
        ),
        Text(
          text2,
          style: AppStyles.w700Style(16, AppColors.black600),
        ),
      ],
    );
  }
}
