// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/core/utils/helpers.dart';
import 'package:kochanet_measure_app/core/utils/images.dart';
import 'package:kochanet_measure_app/core/utils/styles.dart';
import 'package:kochanet_measure_app/features/home/data/models/update_assessment_model.dart';
import 'package:kochanet_measure_app/features/home/presentation/bloc/assessment_questions_bloc.dart';
import 'package:kochanet_measure_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:kochanet_measure_app/features/home/presentation/widgets/assessment_bottom_controls_widget.dart';
import 'package:kochanet_measure_app/features/home/presentation/widgets/assessment_steps_header_widget.dart';
import 'package:kochanet_measure_app/widgets/custom_alerts.dart';

class AssessmentStep4View extends HookWidget {
  AssessmentStep4View({
    super.key,
    required this.id,
    required this.onPreviousPage,
    required this.onNextPage,
    required this.assessmentQuestionsBloc,
    required this.homeBloc,
  });
  final String id;
  final Function() onNextPage;
  final Function() onPreviousPage;
  final HomeBloc homeBloc;
  final AssessmentQuestionsBloc assessmentQuestionsBloc;

  UpdateAssessmentModel updateAssessmentModel = UpdateAssessmentModel();

  @override
  Widget build(BuildContext context) {
    var step4ListItems = useState<List<Map<String, dynamic>>>([
      {
        'asset': AppImages.chickenImg,
        'text': 'Chicken',
        'state': false,
      },
      {
        'asset': AppImages.horseImg,
        'text': 'Horse',
        'state': false,
      },
      {
        'asset': AppImages.dogImg,
        'text': 'Dog',
        'state': false,
      },
    ]);

    final correctValue = useState<int>(0);
    var question4 = useState<String>('Incorrect');
    var question5 = useState<String>('Incorrect');
    var question6 = useState<String>('Incorrect');

    void handleCheckboxChanged(bool value, int index) {
      step4ListItems.value[index]['state'] = value;

      switch (index) {
        case 0:
          question4.value = value ? 'Correct' : 'Incorrect';
          assessmentQuestionsBloc
              .add(SaveQuestion4Event(question4: question4.value));
          break;
        case 1:
          question5.value = value ? 'Correct' : 'Incorrect';
          assessmentQuestionsBloc
              .add(SaveQuestion5Event(question5: question5.value));
          break;
        case 2:
          question6.value = value ? 'Correct' : 'Incorrect';
          assessmentQuestionsBloc
              .add(SaveQuestion6Event(question6: question6.value));
          break;
        default:
          break;
      }

      if (value) {
        correctValue.value++;
      } else {
        correctValue.value--;
      }
    }

    useEffect(() {
      Helpers.saveDefaultAssessmentQuestions(assessmentQuestionsBloc);
      return null;
    }, []);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AssessmentStepsHeaderWidget(
          header: context.l10n.step4HeaderText,
          subHeader: context.l10n.step4SubHeaderText,
        ),
        SizedBox(
          height: context.height * 0.05,
        ),
        ...List.generate(
          step4ListItems.value.length,
          (index) {
            final item = step4ListItems.value[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  color: AppColors.grey200,
                  thickness: 1,
                ),
                AssessmentStep4ItemWidget(
                  state: item['state'] as bool,
                  text: item['text'] as String,
                  asset: item['asset'] as String,
                  onChanged: (value) => handleCheckboxChanged(value, index),
                  onImageClicked: () => Helpers.showImageDialog(context,
                      asset: item['asset'] as String),
                ),
                index == step4ListItems.value.length - 1
                    ? const Divider(
                        color: AppColors.grey200,
                        thickness: 1,
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
        const Spacer(),
        Center(
          child: Text(
            '${correctValue.value} ${context.l10n.correct}',
            style: AppStyles.w800Style(
              14,
              AppColors.orange500,
            ),
          ),
        ),
        SizedBox(
          height: context.height * 0.02,
        ),
        BlocListener<HomeBloc, HomeState>(
          bloc: homeBloc,
          listener: (context, state) {
            if (state is UpdateAssessmentsLoadingState) {
              Helpers.showLoader(context, hasText: true);
            }

            if (state is UpdateAssessmntsFailureState) {
              Helpers.hideLoader(context);
              Alerts.show(state.error, context, isError: true);
            }

            if (state is UpdateAssessmentsSuccessState) {
              Helpers.hideLoader(context);
              onNextPage.call();
            }
          },
          child: BlocBuilder<AssessmentQuestionsBloc, AssessmentQuestions>(
            bloc: assessmentQuestionsBloc,
            builder: (context, state) {
              return AssessmentBottomControlsWidget(
                onPreviousPage: onPreviousPage,
                onNextPage: () {
                  double totalScore = Helpers.getTotalScore(
                    [
                      state.question1,
                      state.question2,
                      state.question3,
                      question4.value,
                      question5.value,
                      question6.value,
                    ],
                  );

                  updateAssessmentModel = UpdateAssessmentModel(
                    question1Answer: state.question1,
                    question2Answer: state.question2,
                    question3Answer: state.question3,
                    question4Answer: question4.value,
                    question5Answer: question5.value,
                    question6Answer: question6.value,
                    totalScore: totalScore,
                  );

                  homeBloc.add(
                    UpdateAssessmentsEvents(
                        id: id, assessment: updateAssessmentModel),
                  );
                },
                text: context.l10n.finistText,
              );
            },
          ),
        ),
      ],
    );
  }
}

class AssessmentStep4ItemWidget extends StatelessWidget {
  const AssessmentStep4ItemWidget({
    super.key,
    required this.state,
    required this.onChanged,
    required this.text,
    required this.asset,
    required this.onImageClicked,
  });

  final bool state;
  final Function(bool) onChanged;
  final String text;
  final String asset;
  final Function() onImageClicked;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onImageClicked,
          child: Container(
            width: context.width * 0.15,
            height: context.height * 0.1,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.grey200, width: 1),
            ),
            child: Center(
              child: Image.asset(
                asset,
                scale: 2.2,
              ),
            ),
          ),
        ),
        SizedBox(
          width: context.width * 0.04,
        ),
        Text(
          text,
          style: AppStyles.w700Style(16, AppColors.black600),
        ),
        const Spacer(),
        CupertinoSwitch(
          value: state,
          onChanged: onChanged,
          thumbColor: AppColors.whiteColor,
          activeColor: AppColors.orange300,
        ),
      ],
    );
  }
}
