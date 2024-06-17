import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/core/utils/styles.dart';
import 'package:kochanet_measure_app/features/home/data/models/assessment_model.dart';
import 'package:kochanet_measure_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:kochanet_measure_app/widgets/custom_search_widget.dart';
import 'package:kochanet_measure_app/widgets/custom_shimmer.dart';
import 'package:kochanet_measure_app/widgets/custom_switcher.dart';
import 'package:kochanet_measure_app/widgets/empty_data_widget.dart';
import 'package:kochanet_measure_app/widgets/patients_history_card.dart';

class HistoryView extends HookWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    var isFilterActive = useState<bool>(false);
    final completedAssessmentsList = useState<List<AssessmentModel>>([]);
    final homeBloc = BlocProvider.of<HomeBloc>(context);

    useEffect(() {
      homeBloc.add(GetAllAssessmentsEvents());
      return;
    }, []);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.historyText,
                style: AppStyles.w700Style(22, AppColors.black600),
              ),
              SizedBox(
                height: context.height * 0.02,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 4,
                    child: CustomSearchWidget(
                      onChanged: (val) {},
                    ),
                  ),
                  SizedBox(
                    width: context.width * 0.02,
                  ),
                  Expanded(
                    flex: 1,
                    child: SearchFilterButton(
                      onTap: () {
                        isFilterActive.value = !isFilterActive.value;
                      },
                      isActive: isFilterActive.value,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: context.height * 0.02,
              ),
              BlocConsumer<HomeBloc, HomeState>(
                bloc: homeBloc,
                listener: (context, state) {
                  if (state is GetAllAssessmentsSuccessState) {
                    completedAssessmentsList.value = state.assessments
                        .where((element) => element.isComplete)
                        .toList();
                  }
                },
                builder: (context, state) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomSwitcher(
                            state: state is! GetAllAssessmentsLoadingState,
                            secondChild:
                                CustomShimmerLoading.patientCardShimmer(
                                    context),
                            firstChild: CustomSwitcher(
                              state: completedAssessmentsList.value.isNotEmpty,
                              secondChild: EmptyDataWidget(
                                text: context.l10n.noDataToShow,
                              ),
                              firstChild: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...List.generate(
                                    completedAssessmentsList.value.length,
                                    (index) {
                                      final assessment =
                                          completedAssessmentsList.value[index];
                                      final time = completedAssessmentsList
                                          .value[index].updatedAt;
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          PatientHistoryCard(
                                            assessment: assessment,
                                            time: time.toString(),
                                          ),
                                          SizedBox(
                                            height: context.height * 0.015,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: context.height * 0.01,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
