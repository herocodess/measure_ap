import 'package:flutter/material.dart';
import 'package:kochanet_measure_app/core/router/app_routes.dart';
import 'package:kochanet_measure_app/core/router/navigation_service.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/core/utils/helpers.dart';
import 'package:kochanet_measure_app/core/utils/images.dart';
import 'package:kochanet_measure_app/core/utils/styles.dart';
import 'package:kochanet_measure_app/features/home/data/models/assessment_model.dart';
import 'package:kochanet_measure_app/widgets/row_with_circle_dot_spacer.dart';

class PatientHistoryCard extends StatelessWidget {
  const PatientHistoryCard({
    super.key,
    required this.assessment,
    required this.time,
  });
  final AssessmentModel assessment;
  final String time;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          pushTo(context, AppRoutes.historyDetails.path, extra: assessment),
      child: Container(
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                      color: AppColors.blue500.withOpacity(0.12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          assessment.id.substring(0, 4).toUpperCase(),
                          style: AppStyles.w800Style(14, AppColors.blue700),
                        ),
                        SizedBox(
                          width: context.width * 0.015,
                        ),
                        Image.asset(
                          AppImages.circleDotImg,
                          scale: 2.2,
                        ),
                        SizedBox(
                          width: context.width * 0.015,
                        ),
                        Text(
                          assessment.cognitiveStatus,
                          style: AppStyles.w500Style(14, AppColors.blue700),
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
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              assessment.patient.fullname,
              style: AppStyles.w600Style(18, AppColors.black600),
            ),
            SizedBox(
              height: context.height * 0.01,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                RowWithCircleDotSpacer(
                  text: assessment.patient.gender,
                ),
                RowWithCircleDotSpacer(
                  text: '${assessment.patient.age} Years Old',
                ),
                RowWithCircleDotSpacer(
                  text: '${assessment.patient.weight}kg',
                  isLast: true,
                ),
                const Spacer(),
                Text(
                  Helpers.parseTimeStampToReadableFormat(
                      assessment.updatedAt?.toDate() ?? DateTime.now()),
                  style: AppStyles.w700Style(14, AppColors.grey600),
                ),
              ],
            ),
            SizedBox(
              height: context.height * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}
