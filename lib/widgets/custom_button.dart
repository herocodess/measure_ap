import 'package:flutter/material.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/core/utils/images.dart';

class PrimaryGradientButton extends StatelessWidget {
  const PrimaryGradientButton({
    super.key,
    required this.onTap,
    required this.text,
    this.hasIcon = false,
    this.textColor,
    this.buttonColor,
    this.textSize,
    this.textWeight,
    this.width,
    this.height,
    this.useRow = false,
  });
  final Function()? onTap;
  final String text;
  final Color? textColor;
  final Color? buttonColor;
  final double? textSize;
  final FontWeight? textWeight;
  final bool hasIcon;
  final double? width, height;
  final bool useRow;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? context.height * 0.08,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            height: height ?? context.height * 0.08,
          ),
          Transform.translate(
            offset: Offset(0, useRow ? 30 : 20),
            child: Image.asset(
              AppImages.gradientImg,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: width ?? context.width,
              height: height ?? context.height * 0.08,
              decoration: BoxDecoration(
                color: buttonColor ?? AppColors.black600,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (hasIcon)
                      const Icon(
                        Icons.add,
                        size: 18,
                        color: AppColors.whiteColor,
                      ),
                    if (hasIcon)
                      SizedBox(
                        width: context.width * 0.02,
                      ),
                    Text(
                      text,
                      style: TextStyle(
                        color: textColor ?? AppColors.whiteColor,
                        fontSize: textSize ?? 16,
                        fontWeight: textWeight ?? FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IconPreviousButton extends StatelessWidget {
  const IconPreviousButton({super.key, required this.onTap});
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: context.height * 0.08,
        width: context.height * 0.05,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(70),
          ),
          border: Border.all(color: AppColors.grey400),
        ),
        child: const Center(
          child: Icon(
            Icons.arrow_back_ios,
            size: 16,
            color: AppColors.black600,
          ),
        ),
      ),
    );
  }
}

class OutlinedPreviousButton extends StatelessWidget {
  const OutlinedPreviousButton({
    super.key,
    required this.onTap,
    this.text,
    this.hasIcon = false,
    this.textColor,
    this.borderColor,
    this.textSize,
    this.textWeight,
    this.width,
    this.height,
  });

  final Function()? onTap;
  final String? text;
  final Color? textColor;
  final Color? borderColor;
  final double? textSize;
  final FontWeight? textWeight;
  final bool hasIcon;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? context.width,
        height: height ?? context.height * 0.08,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: borderColor ?? AppColors.grey400,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (hasIcon)
                const Icon(
                  Icons.add,
                  size: 18,
                  color: AppColors.whiteColor,
                ),
              if (hasIcon)
                SizedBox(
                  width: context.width * 0.02,
                ),
              Text(
                text ?? context.l10n.backText,
                style: TextStyle(
                  color: textColor ?? AppColors.black600,
                  fontSize: textSize ?? 16,
                  fontWeight: textWeight ?? FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
