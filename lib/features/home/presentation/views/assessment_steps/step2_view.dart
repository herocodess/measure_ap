// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/features/home/presentation/bloc/assessment_questions_bloc.dart';
import 'package:kochanet_measure_app/features/home/presentation/widgets/assessment_bottom_controls_widget.dart';
import 'package:kochanet_measure_app/features/home/presentation/widgets/assessment_steps_header_widget.dart';
import 'package:kochanet_measure_app/features/home/presentation/widgets/assessment_steps_item_widget.dart';
import 'package:kochanet_measure_app/widgets/custom_alerts.dart';

class AssessmentStep2View extends HookWidget {
  AssessmentStep2View(
      {super.key,
      required this.onPreviousPage,
      required this.onNextPage,
      required this.assessmentQuestionsBloc});
  final Function() onNextPage;
  final Function() onPreviousPage;
  final AssessmentQuestionsBloc assessmentQuestionsBloc;

  final step2ListItems = [
    'Jill bought candies.',
    'Jill has a dog as a pet.',
    'Jill took a cab.'
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndices = useState<List<int>>([]);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AssessmentStepsHeaderWidget(
          header: context.l10n.step2HeaderText,
          subHeader: context.l10n.step2SubHeaderText,
        ),
        SizedBox(
          height: context.height * 0.05,
        ),
        ...List.generate(
          step2ListItems.length,
          (index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AssessmentStepsItemWidget(
                onTap: () {
                  if (selectedIndices.value.contains(index)) {
                    selectedIndices.value = List.from(selectedIndices.value)
                      ..remove(index);
                  } else {
                    if (selectedIndices.value.length >= 2) {
                      selectedIndices.value.removeAt(0);
                    }
                    selectedIndices.value = List.from(selectedIndices.value)
                      ..add(index);
                  }
                  selectedIndices.notifyListeners();
                },
                hasCheckbox: true,
                isSelected: selectedIndices.value.contains(index),
                text: step2ListItems[index],
              ),
              SizedBox(
                height: context.height * 0.02,
              ),
            ],
          ),
        ),
        const Spacer(),
        AssessmentBottomControlsWidget(
          onPreviousPage: onPreviousPage,
          onNextPage: () {
            if (selectedIndices.value.isEmpty) {
              Alerts.show('Please select an option', isError: true, context);
              return;
            }

            if (selectedIndices.value.contains(0)) {
              assessmentQuestionsBloc.add(
                SaveQuestion2Event(
                  question2: 'Correct',
                ),
              );
            }

            if (selectedIndices.value.contains(1)) {
              assessmentQuestionsBloc.add(
                SaveQuestion2Event(
                  question2: 'Incorrect',
                ),
              );
            }

            if (selectedIndices.value.contains(2)) {
              assessmentQuestionsBloc.add(
                SaveQuestion3Event(
                  question3: 'Correct',
                ),
              );
            }

            if (!selectedIndices.value.contains(2)) {
              assessmentQuestionsBloc.add(
                SaveQuestion3Event(
                  question3: 'Incorrect',
                ),
              );
            }
            onNextPage.call();
          },
        ),
      ],
    );
  }
}
