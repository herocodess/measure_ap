import 'package:flutter/material.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/core/utils/styles.dart';

class HistoryPatientItemDetailsWidget extends StatelessWidget {
  const HistoryPatientItemDetailsWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.subtitle,
      this.hasSecondSubtitle = false,
      this.secondSubtite});

  final String title;
  final String icon;
  final String subtitle;
  final bool hasSecondSubtitle;
  final String? secondSubtite;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.w700Style(14, AppColors.grey600),
        ),
        SizedBox(
          height: context.height * 0.01,
        ),
        Container(
          width: context.width,
          height: context.height * 0.06,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
            color: AppColors.greyBg,
          ),
          child: Row(
            children: [
              Image.asset(
                icon,
                scale: 2.1,
              ),
              SizedBox(
                width: context.width * 0.02,
              ),
              Text(
                subtitle,
                style: AppStyles.w500Style(15, AppColors.black600),
              ),
              if (hasSecondSubtitle)
                SizedBox(
                  width: context.width * 0.02,
                ),
              if (hasSecondSubtitle)
                Text(
                  '($secondSubtite)',
                  style: AppStyles.w500Style(16, AppColors.grey600),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
