import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/styles.dart';

class InputFields extends StatelessWidget {
  const InputFields({
    super.key,
    required this.hint,
    required this.controller,
    this.label,
    this.labelSuffix,
    this.onLabelSuffixTap,
    this.suffixIcon,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.read = false,
    this.isPassword = false,
    this.validator,
    this.onChanged,
    this.textInputAction,
    this.inputFormatters,
    this.onTap,
    this.focusedBorder,
    this.maxLength,
    this.fillColor,
    this.enabled = true,
    this.filled = false,
    this.maxForceLength,
    this.prefixIcon,
    this.autofocus = false,
    this.focusNode,
    this.maxLines = 1,
  });

  final String? label, labelSuffix;
  final String hint;
  final void Function()? onLabelSuffixTap;
  final Widget? suffixIcon;
  final bool read;
  final TextInputType? keyboardType;
  final bool? isPassword;
  final TextEditingController? controller;
  final TextCapitalization textCapitalization;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onTap;
  final InputBorder? focusedBorder;
  final int? maxLength;
  final bool? enabled;
  final Widget? prefixIcon;
  final Color? fillColor;
  final int maxLines;
  final MaxLengthEnforcement? maxForceLength;
  final bool? filled;
  final bool autofocus;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != '' || label != null)
          Text(
            label!,
            style: AppStyles.w700Style(14, AppColors.grey600),
          ),
        const SizedBox(height: 5),
        Container(
          color: AppColors.whiteColor,
          child: TextFormField(
            key: key,
            onTap: onTap,
            maxLines: maxLines,
            autofocus: autofocus,
            autovalidateMode: autovalidateMode,
            maxLengthEnforcement: maxForceLength,
            maxLength: maxLength,
            focusNode: focusNode,
            onTapOutside: (_) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            inputFormatters: inputFormatters,
            textInputAction: textInputAction,
            style: AppStyles.w500Style(16, AppColors.grey600),
            readOnly: read,
            enabled: enabled,
            controller: controller,
            validator: validator,
            keyboardType: keyboardType ?? TextInputType.text,
            textCapitalization: textCapitalization,
            onChanged: onChanged,
            obscureText: isPassword! == true ? true : false,
            cursorColor: AppColors.black600,
            cursorHeight: 15,
            decoration: InputDecoration(
              fillColor: fillColor ?? AppColors.whiteColor.withOpacity(0.3),
              errorStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.normalRed,
              ),
              filled: filled,
              errorMaxLines: 3,
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.greyColor.withOpacity(0.3)),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              enabledBorder: focusedBorder ??
                  const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.grey200,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
              disabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.greyColor.withOpacity(0.3)),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: focusedBorder ??
                  const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.grey200,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
              hintText: hint,
              hintStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grey600),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
