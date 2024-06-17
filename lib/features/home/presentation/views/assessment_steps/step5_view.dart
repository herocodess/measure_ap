import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kochanet_measure_app/core/managers/app_manager.dart';
import 'package:kochanet_measure_app/core/router/app_router.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/core/utils/helpers.dart';
import 'package:kochanet_measure_app/core/utils/styles.dart';
import 'package:kochanet_measure_app/features/home/presentation/bloc/assessment_questions_bloc.dart';
import 'package:kochanet_measure_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:kochanet_measure_app/widgets/assessment_summary_circle_indicator.dart';
import 'package:kochanet_measure_app/widgets/assessment_summary_list_tile_widget.dart';
import 'package:kochanet_measure_app/widgets/custom_button.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../../core/utils/colors.dart';

class AssessmentStep5View extends HookWidget {
  const AssessmentStep5View(
      {super.key,
      required this.onPreviousPage,
      required this.homeBloc,
      required this.assessmentQuestionsBloc});
  final Function() onPreviousPage;
  final HomeBloc homeBloc;
  final AssessmentQuestionsBloc assessmentQuestionsBloc;

  @override
  Widget build(BuildContext context) {
    final screenshotController =
        useState<ScreenshotController>(ScreenshotController());
    final showAllClicked = useState<bool>(false);
    return Column(
      children: [
        SizedBox(
          height: context.height * 0.05,
        ),
        Center(
          child: Text(
            context.l10n.step5HeaderText,
            textAlign: TextAlign.center,
            style: AppStyles.w700Style(24, AppColors.black600, height: 1.2),
          ),
        ),
        SizedBox(
          height: context.height * 0.05,
        ),
        Screenshot(
          controller: screenshotController.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<AssessmentQuestionsBloc, AssessmentQuestions>(
                bloc: assessmentQuestionsBloc,
                builder: (context, state) {
                  double totalScore = Helpers.getTotalScore(
                    [
                      state.question1,
                      state.question2,
                      state.question3,
                      state.question4,
                      state.question5,
                      state.question6,
                    ],
                  );

                  List<Map<String, String>> questionsList = [
                    {'key': 'Question 1', 'value': state.question1},
                    {'key': 'Question 2', 'value': state.question2},
                    {'key': 'Question 3', 'value': state.question3},
                    {'key': 'Question 4', 'value': state.question4},
                    {'key': 'Question 5', 'value': state.question5},
                    {'key': 'Question 6', 'value': state.question6},
                  ];
                  return Container(
                    width: context.width,
                    height: showAllClicked.value
                        ? context.height * 0.5
                        : context.height * 0.43,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      border: Border.all(color: AppColors.grey200),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(2, 4),
                          color: AppColors.blackColor.withOpacity(.1),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AssessmentSummaryCircleIndicator(
                            totalScore: totalScore),
                        SizedBox(
                          height: context.height * 0.01,
                        ),
                        const Divider(),
                        SizedBox(
                          height: context.height * 0.01,
                        ),
                        ...List.generate(
                          showAllClicked.value
                              ? questionsList.length
                              : questionsList.take(4).length,
                          (index) {
                            final question = questionsList[index];
                            return AssessmentSummaryListTileWidget(
                              text: question['key'] as String,
                              value: question['value'] as String,
                            );
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            showAllClicked.value = !showAllClicked.value;
                          },
                          child: Text(
                            context.l10n.showAll,
                            style: AppStyles.w800Style(14, AppColors.orange500),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const Spacer(),
        Row(
          children: [
            Expanded(
              child: OutlinedPreviousButton(
                onTap: () {
                  homeBloc.add(GetAllAssessmentsEvents());
                  locator.get<RouterClass>().navigationShell?.goBranch(0);
                },
                textWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              width: context.width * 0.02,
            ),
            Expanded(
              child: PrimaryGradientButton(
                text: context.l10n.printText,
                onTap: () =>
                    Helpers.printDocument(screenshotController.value, context),
                useRow: true,
                textWeight: FontWeight.w700,
              ),
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
