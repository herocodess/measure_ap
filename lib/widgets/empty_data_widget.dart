import 'package:flutter/material.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/core/utils/styles.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: context.height * 0.05,
        ),
        Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: AppStyles.w700Style(14, AppColors.black600.withOpacity(0.7)),
          ),
        ),
        SizedBox(
          height: context.height * 0.05,
        ),
      ],
    );
  }
}
