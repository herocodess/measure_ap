import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kochanet_measure_app/core/managers/app_manager.dart';
import 'package:kochanet_measure_app/core/router/app_router.dart';
import 'package:kochanet_measure_app/core/router/app_routes.dart';
import 'package:kochanet_measure_app/core/router/navigation_service.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/enums.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/core/utils/helpers.dart';
import 'package:kochanet_measure_app/core/utils/images.dart';
import 'package:kochanet_measure_app/core/utils/styles.dart';
import 'package:kochanet_measure_app/features/home/data/models/assessment_model.dart';
import 'package:kochanet_measure_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:kochanet_measure_app/features/home/presentation/widgets/app_bar_text_item_widget.dart';
import 'package:kochanet_measure_app/features/home/presentation/widgets/recent_assessments_widget.dart';
import 'package:kochanet_measure_app/features/home/presentation/widgets/see_more_widget.dart';
import 'package:kochanet_measure_app/widgets/custom_button.dart';
import 'package:kochanet_measure_app/widgets/custom_shimmer.dart';
import 'package:kochanet_measure_app/widgets/custom_switcher.dart';
import 'package:kochanet_measure_app/widgets/empty_data_widget.dart';
import 'package:kochanet_measure_app/widgets/patients_history_card.dart';

class HomeView extends HookWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final completedAssessmentsList = useState<List<AssessmentModel>>([]);
    final pendingAssessmentsList = useState<List<AssessmentModel>>([]);
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage(AppImages.drJohnsonImg),
                  ),
                  SizedBox(
                    width: context.width * 0.02,
                  ),
                  AppBarTextItemWidget(
                    text1: context.l10n.welcomeBack,
                    text2: context.l10n.drJohnson,
                  ),
                  const Spacer(),
                  AppBarTextItemWidget(
                    text1: Helpers.getCurrentDayAndDate(DayDateOptions.day),
                    text2: Helpers.getCurrentDayAndDate(DayDateOptions.date),
                  ),
                ],
              ),
              SizedBox(
                height: context.height * 0.04,
              ),
              BlocConsumer<HomeBloc, HomeState>(
                bloc: homeBloc,
                listener: (context, state) {
                  if (state is GetAllAssessmentsSuccessState) {
                    completedAssessmentsList.value = state.assessments
                        .where((element) => element.isComplete)
                        .toList();

                    pendingAssessmentsList.value = state.assessments
                        .where((element) => !element.isComplete)
                        .toList();
                  }
                },
                builder: (context, state) {
                  if (state is GetAllAssessmentsFailureState) {
                    return Center(
                      child: Text(state.error),
                    );
                  }

                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                context.l10n.recentHistory,
                                style:
                                    AppStyles.w700Style(18, AppColors.black600),
                              ),
                              const Spacer(),
                              SeeMoreWidget(
                                onTap: () => locator
                                    .get<RouterClass>()
                                    .navigationShell
                                    ?.goBranch(2),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: context.height * 0.02,
                          ),
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
                                    completedAssessmentsList.value
                                        .take(3)
                                        .length,
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
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                context.l10n.recentAssessments,
                                style:
                                    AppStyles.w700Style(18, AppColors.black600),
                              ),
                              const Spacer(),
                              SeeMoreWidget(
                                onTap: () {},
                              ),
                            ],
                          ),
                          SizedBox(
                            height: context.height * 0.02,
                          ),
                          CustomSwitcher(
                            state: state is! GetAllAssessmentsLoadingState,
                            secondChild:
                                CustomShimmerLoading.recentAssessmentsShimmer(
                                    context),
                            firstChild: CustomSwitcher(
                              state: pendingAssessmentsList.value.isNotEmpty,
                              secondChild: EmptyDataWidget(
                                text: context.l10n.noPendingAssessments,
                              ),
                              firstChild: Column(
                                children: [
                                  ...List.generate(
                                    pendingAssessmentsList.value.take(3).length,
                                    (index) {
                                      final data =
                                          pendingAssessmentsList.value[index];
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RecentAssessmentsCard(
                                            cognitiveStatus:
                                                data.cognitiveStatus,
                                            applicableMeasures:
                                                data.applicableMeasures,
                                            onTap: () {
                                              pushTo(context,
                                                  AppRoutes.newAssessment.path,
                                                  extra: data);
                                            },
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
                            height: context.height * 0.03,
                          ),
                          PrimaryGradientButton(
                            onTap: () =>
                                pushTo(context, AppRoutes.newAssessment.path),
                            text: context.l10n.newAssessment,
                            hasIcon: true,
                            textWeight: FontWeight.w800,
                          ),
                          SizedBox(
                            height: context.height * 0.015,
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

class EmptyStateWidget {}
