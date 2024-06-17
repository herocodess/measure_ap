import 'package:flutter/material.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/styles.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AssessmentSummaryCircleIndicator extends StatelessWidget {
  const AssessmentSummaryCircleIndicator({
    super.key,
    required this.totalScore,
  });

  final double totalScore;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularPercentIndicator(
        radius: 76.0,
        lineWidth: 15.0,
        percent: totalScore / 18,
        center: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              totalScore.toString().split('.').first,
              style: AppStyles.w700Style(36, AppColors.black600),
            ),
            Text(
              '/18',
              style: AppStyles.w600Style(14, AppColors.grey600),
            ),
          ],
        ),
        progressColor: AppColors.green400,
        backgroundColor: AppColors.normalGrey.withOpacity(0.2),
        circularStrokeCap: CircularStrokeCap.butt,
      ),
    );
  }
}
