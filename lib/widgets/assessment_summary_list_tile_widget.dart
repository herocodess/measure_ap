import 'package:flutter/material.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/core/utils/helpers.dart';
import 'package:kochanet_measure_app/core/utils/styles.dart';

class AssessmentSummaryListTileWidget extends StatelessWidget {
  const AssessmentSummaryListTileWidget({
    super.key,
    required this.text,
    required this.value,
  });

  final String text;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              text,
              style: AppStyles.w500Style(14, AppColors.black600),
            ),
            const Spacer(),
            Text(
              value,
              style:
                  AppStyles.w700Style(14, Helpers.getColorBasedOnText(value)),
            ),
          ],
        ),
        SizedBox(
          height: context.height * 0.02,
        ),
      ],
    );
  }
}
