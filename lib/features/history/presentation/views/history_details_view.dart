import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/core/utils/helpers.dart';
import 'package:kochanet_measure_app/core/utils/images.dart';
import 'package:kochanet_measure_app/core/utils/styles.dart';
import 'package:kochanet_measure_app/features/history/presentation/widgets/history_patient_item_details_widget.dart';
import 'package:kochanet_measure_app/features/home/data/models/assessment_model.dart';
import 'package:kochanet_measure_app/widgets/assessment_summary_circle_indicator.dart';
import 'package:kochanet_measure_app/widgets/assessment_summary_list_tile_widget.dart';
import 'package:kochanet_measure_app/widgets/in_app_bar.dart';

class HistoryDetailsView extends StatefulHookWidget {
  const HistoryDetailsView({super.key, required this.assessment});
  final AssessmentModel assessment;

  @override
  State<HistoryDetailsView> createState() => _HistoryDetailsViewState();
}

class _HistoryDetailsViewState extends State<HistoryDetailsView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightAnimation;
  bool viewFullDetails = false;
  bool hasReachedFullHeight = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..addListener(() {
        if (_controller.isCompleted && viewFullDetails) {
          setState(() {
            hasReachedFullHeight = true;
          });
        } else if (_controller.isDismissed && !viewFullDetails) {
          setState(() {
            hasReachedFullHeight = false;
          });
        }
      });

    _heightAnimation = Tween<double>(
      begin: 0.11,
      end: 0.56,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleView() {
    setState(() {
      viewFullDetails = !viewFullDetails;
      if (viewFullDetails) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InAppBar(
                text: context.l10n.historyDetailsText,
              ).paddingSymmetric(h: 20),
              SizedBox(
                height: context.height * 0.02,
              ),
              Container(
                width: context.width,
                height: context.height * 0.19,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          context.l10n.icdoCode,
                          style: AppStyles.w700Style(14, AppColors.grey600),
                        ),
                        const Spacer(),
                        Text(
                          '${context.l10n.lastUpdated} ${Helpers.parseTimeStampToReadableFormat(widget.assessment.updatedAt?.toDate() ?? DateTime.now())}',
                          style: AppStyles.w700Style(14, AppColors.grey600),
                        ),
                      ],
                    ),
                    SizedBox(height: context.height * 0.02),
                    Container(
                      width: context.width,
                      height: context.height * 0.1,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.orange400.withOpacity(0.12),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.assessment.id.substring(0, 5).toUpperCase(),
                            style: AppStyles.w800Style(
                              20,
                              AppColors.orange600,
                            ),
                          ),
                          SizedBox(height: context.height * 0.02),
                          Text(
                            widget.assessment.cognitiveStatus,
                            style: AppStyles.w500Style(
                              16,
                              AppColors.orange600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: context.height * 0.03,
              ),
              Container(
                width: context.width,
                height: context.height * 0.1,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.assessmentDate,
                      style: AppStyles.w700Style(14, AppColors.grey600),
                    ),
                    const Spacer(),
                    Text(
                      Helpers.parseTimeStampToReadableFormat(
                          widget.assessment.updatedAt?.toDate() ??
                              DateTime.now()),
                      style: AppStyles.w700Style(18, AppColors.black600),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: context.height * 0.03,
              ),
              AnimatedBuilder(
                  animation: _heightAnimation,
                  builder: (context, child) {
                    return Container(
                      width: context.width,
                      height: context.height * _heightAnimation.value,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 15),
                      decoration: const BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.assessment.patient.fullname,
                                    style: AppStyles.w700Style(
                                        22, AppColors.black600),
                                  ),
                                  SizedBox(height: context.height * 0.01),
                                  Text(
                                    '#26213082',
                                    style: AppStyles.w700Style(
                                        14, AppColors.grey600),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: toggleView,
                                child: RotatedBox(
                                  quarterTurns: viewFullDetails ? 1 : 3,
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    size: 14,
                                    color: AppColors.black600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (hasReachedFullHeight && !_controller.isAnimating)
                            SizedBox(
                              height: context.height * 0.04,
                            ),
                          if (hasReachedFullHeight && !_controller.isAnimating)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: HistoryPatientItemDetailsWidget(
                                        title: context.l10n.patientGender,
                                        icon: AppImages.genderImg,
                                        subtitle:
                                            widget.assessment.patient.gender,
                                      ),
                                    ),
                                    SizedBox(
                                      width: context.width * 0.03,
                                    ),
                                    Expanded(
                                      child: HistoryPatientItemDetailsWidget(
                                        title: context.l10n.weight,
                                        icon: AppImages.weightImg,
                                        subtitle:
                                            widget.assessment.patient.weight,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: context.height * 0.02,
                                ),
                                ...List.generate(
                                    Helpers.getPatientDetailsList(
                                            widget.assessment, context)
                                        .length, (index) {
                                  final details = Helpers.getPatientDetailsList(
                                      widget.assessment, context)[index];
                                  return Column(
                                    children: [
                                      HistoryPatientItemDetailsWidget(
                                        title: details['title'] as String,
                                        icon: details['icon'] as String,
                                        subtitle: details['subtitle'] as String,
                                        hasSecondSubtitle:
                                            details['hasSecondSubtitle']
                                                as bool,
                                        secondSubtite: details['secondSubtitle']
                                            as String?,
                                      ),
                                      index ==
                                              Helpers.getPatientDetailsList(
                                                          widget.assessment,
                                                          context)
                                                      .length -
                                                  1
                                          ? const SizedBox.shrink()
                                          : SizedBox(
                                              height: context.height * 0.02,
                                            ),
                                    ],
                                  );
                                })
                              ],
                            ),
                        ],
                      ),
                    );
                  }),
              SizedBox(
                height: context.height * 0.03,
              ),
              Container(
                width: context.width,
                height: context.height * 0.5,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  children: [
                    AssessmentSummaryCircleIndicator(
                        totalScore: widget.assessment.totalScore ?? 0.0),
                    SizedBox(
                      height: context.height * 0.01,
                    ),
                    const Divider(),
                    SizedBox(
                      height: context.height * 0.01,
                    ),
                    ...List.generate(
                      Helpers.getAssessmentQuestionsList(widget.assessment)
                          .length,
                      (index) {
                        final question = Helpers.getAssessmentQuestionsList(
                            widget.assessment)[index];
                        return AssessmentSummaryListTileWidget(
                          text: question['key'] as String,
                          value: question['value'] as String,
                        );
                      },
                    ),
                  ],
                ),
              ).paddingSymmetric(h: 20),
            ],
          ),
        ),
      ),
    );
  }
}
