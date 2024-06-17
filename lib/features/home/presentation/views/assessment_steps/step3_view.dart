import 'package:flutter/material.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/core/utils/styles.dart';
import 'package:kochanet_measure_app/features/home/presentation/widgets/assessment_bottom_controls_widget.dart';

class AssessmentStep3View extends StatelessWidget {
  const AssessmentStep3View({
    super.key,
    required this.onPreviousPage,
    required this.onNextPage,
  });
  final Function() onNextPage;
  final Function() onPreviousPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.height * 0.05,
        ),
        Text(
          context.l10n.step3HeaderText,
          style: AppStyles.w500Style(14, AppColors.grey600),
        ),
        SizedBox(
          height: context.height * 0.02,
        ),
        Text(
          context.l10n.readTheSentences,
          textAlign: TextAlign.center,
          style: AppStyles.w700Style(24, AppColors.black600, height: 1.2),
        ),
        SizedBox(
          height: context.height * 0.05,
        ),
        Text(
          context.l10n.sentence1,
          textAlign: TextAlign.justify,
          style: AppStyles.w500Style(14, AppColors.grey600, height: 1.2),
        ),
        SizedBox(
          height: context.height * 0.02,
        ),
        Text(
          context.l10n.sentence2,
          textAlign: TextAlign.justify,
          style: AppStyles.w500Style(14, AppColors.grey600, height: 1.2),
        ),
        SizedBox(
          height: context.height * 0.02,
        ),
        Text(
          context.l10n.sentence3,
          textAlign: TextAlign.justify,
          style: AppStyles.w500Style(14, AppColors.grey600, height: 1.2),
        ),
        const Spacer(),
        AssessmentBottomControlsWidget(
          onPreviousPage: onPreviousPage,
          onNextPage: onNextPage,
        ),
      ],
    );
  }
}
