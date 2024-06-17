import 'package:flutter/material.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/core/utils/styles.dart';

class AssessmentStepsItemWidget extends StatelessWidget {
  const AssessmentStepsItemWidget(
      {super.key,
      required this.isSelected,
      required this.text,
      required this.onTap,
      this.hasCheckbox = false});
  final bool isSelected;
  final bool hasCheckbox;
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 700),
        height: context.height * 0.1,
        width: context.width,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(13),
          ),
          border: Border.all(
            width: 2,
            color: isSelected ? AppColors.orange700 : AppColors.grey200,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    offset: const Offset(0, 4),
                    color: AppColors.blackColor.withOpacity(.1),
                  ),
                ]
              : [],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (hasCheckbox)
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      isSelected ? AppColors.orange700 : AppColors.whiteColor,
                  border: Border.all(
                    color: isSelected ? AppColors.orange700 : AppColors.grey200,
                  ),
                ),
                child: isSelected
                    ? const Center(
                        child: Icon(
                          Icons.check,
                          color: AppColors.whiteColor,
                        ),
                      )
                    : null,
              ),
            if (hasCheckbox)
              SizedBox(
                width: context.width * 0.02,
              ),
            Text(
              text,
              style: AppStyles.w700Style(18, AppColors.black600),
            ),
          ],
        ),
      ),
    );
  }
}
