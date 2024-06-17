import 'package:flutter/material.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/widgets/custom_button.dart';

class AssessmentBottomControlsWidget extends StatelessWidget {
  const AssessmentBottomControlsWidget({
    super.key,
    required this.onPreviousPage,
    required this.onNextPage,
    this.text,
  });

  final Function() onPreviousPage;
  final Function() onNextPage;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: IconPreviousButton(onTap: onPreviousPage),
            ),
            SizedBox(
              width: context.width * 0.02,
            ),
            Expanded(
              flex: 3,
              child: PrimaryGradientButton(
                onTap: onNextPage,
                text: text ?? context.l10n.continueText,
                useRow: true,
                textWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(
          height: context.height * 0.02,
        ),
      ],
    );
  }
}
