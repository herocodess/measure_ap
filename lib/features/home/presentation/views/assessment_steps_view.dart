import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kochanet_measure_app/core/managers/app_manager.dart';
import 'package:kochanet_measure_app/core/router/app_router.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/core/utils/images.dart';
import 'package:kochanet_measure_app/core/utils/styles.dart';
import 'package:kochanet_measure_app/features/home/presentation/bloc/assessment_questions_bloc.dart';
import 'package:kochanet_measure_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:kochanet_measure_app/features/home/presentation/views/assessment_steps/step1_view.dart';
import 'package:kochanet_measure_app/features/home/presentation/views/assessment_steps/step2_view.dart';
import 'package:kochanet_measure_app/features/home/presentation/views/assessment_steps/step3_view.dart';
import 'package:kochanet_measure_app/features/home/presentation/views/assessment_steps/step4_view.dart';
import 'package:kochanet_measure_app/features/home/presentation/views/assessment_steps/step5_view.dart';

class AssessmentStepsView extends StatefulHookWidget {
  const AssessmentStepsView({super.key, required this.id});
  final String id;

  @override
  State<AssessmentStepsView> createState() => _AssessmentViewState();
}

class _AssessmentViewState extends State<AssessmentStepsView> {
  @override
  Widget build(BuildContext context) {
    final currentPage = useState<int>(0);
    final pageController = usePageController();
    log('id passed   => ${widget.id}');
    final assessmentQuestionsBloc =
        BlocProvider.of<AssessmentQuestionsBloc>(context);
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      homeBloc.add(GetAllAssessmentsEvents());
                      locator.get<RouterClass>().navigationShell?.goBranch(0);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 14,
                      color: AppColors.black600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    context.l10n.assessment,
                    style: AppStyles.w800Style(16, AppColors.black600),
                  ),
                  const Spacer(),
                  Image.asset(
                    AppImages.moreImg,
                    scale: 1.9,
                  )
                ],
              ),
              SizedBox(
                height: context.height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    5,
                    (index) {
                      final isActive = currentPage.value >= index;
                      return Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 1000),
                            height: context.height * 0.007,
                            width: context.width * 0.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(56),
                              color: isActive
                                  ? AppColors.black600
                                  : AppColors.grey200,
                            ),
                          ),
                          SizedBox(
                            width: context.width * 0.02,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: context.height * 0.02,
              ),
              Expanded(
                child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (value) {
                    currentPage.value = value;
                  },
                  children: [
                    AssessmentStep1View(
                      assessmentQuestionsBloc: assessmentQuestionsBloc,
                      onPageChanged: () {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                    ),
                    AssessmentStep2View(
                      assessmentQuestionsBloc: assessmentQuestionsBloc,
                      onNextPage: () {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      onPreviousPage: () {
                        pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                    ),
                    AssessmentStep3View(
                      onNextPage: () {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      onPreviousPage: () {
                        pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                    ),
                    AssessmentStep4View(
                      id: widget.id,
                      assessmentQuestionsBloc: assessmentQuestionsBloc,
                      homeBloc: homeBloc,
                      onNextPage: () {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      onPreviousPage: () {
                        pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                    ),
                    AssessmentStep5View(
                      homeBloc: homeBloc,
                      assessmentQuestionsBloc: assessmentQuestionsBloc,
                      onPreviousPage: () {
                        pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
