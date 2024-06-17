import 'package:flutter/material.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/core/utils/styles.dart';

class AssessmentStepsHeaderWidget extends StatelessWidget {
  const AssessmentStepsHeaderWidget(
      {super.key, required this.header, required this.subHeader});
  final String header;
  final String subHeader;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.height * 0.05,
        ),
        Text(
          header,
          textAlign: TextAlign.center,
          style: AppStyles.w700Style(24, AppColors.black600, height: 1.2),
        ),
        SizedBox(
          height: context.height * 0.02,
        ),
        Text(
          subHeader,
          textAlign: TextAlign.center,
          style: AppStyles.w500Style(14, AppColors.grey600, height: 1.2),
        ),
      ],
    );
  }
}
