import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/features/home/presentation/bloc/assessment_questions_bloc.dart';
import 'package:kochanet_measure_app/features/home/presentation/widgets/assessment_steps_header_widget.dart';
import 'package:kochanet_measure_app/features/home/presentation/widgets/assessment_steps_item_widget.dart';
import 'package:kochanet_measure_app/widgets/custom_alerts.dart';
import 'package:kochanet_measure_app/widgets/custom_button.dart';

class AssessmentStep1View extends HookWidget {
  AssessmentStep1View(
      {super.key,
      required this.onPageChanged,
      required this.assessmentQuestionsBloc});
  final Function() onPageChanged;
  final AssessmentQuestionsBloc assessmentQuestionsBloc;

  final step1ListItems = ['Correct', 'Incorrect'];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState<int>(-1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AssessmentStepsHeaderWidget(
          header: context.l10n.step1HeaderText,
          subHeader: context.l10n.step1SubHeaderText,
        ),
        SizedBox(
          height: context.height * 0.05,
        ),
        ...List.generate(
          step1ListItems.length,
          (index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AssessmentStepsItemWidget(
                onTap: () {
                  selectedIndex.value = index;
                },
                isSelected: selectedIndex.value == index,
                text: step1ListItems[index],
              ),
              SizedBox(
                height: context.height * 0.02,
              ),
            ],
          ),
        ),
        const Spacer(),
        PrimaryGradientButton(
          onTap: () {
            if (selectedIndex.value < 0) {
              Alerts.show('Please select an option', isError: true, context);
              return;
            }
            assessmentQuestionsBloc.add(
              SaveQuestion1Event(
                question1: step1ListItems[selectedIndex.value],
              ),
            );
            onPageChanged.call();
          },
          text: context.l10n.continueText,
        ),
        SizedBox(
          height: context.height * 0.02,
        ),
      ],
    );
  }
}
