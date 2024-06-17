import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/core/utils/styles.dart';

class CustomDropdown extends StatefulHookWidget {
  const CustomDropdown({
    super.key,
    this.selectedValue,
    required this.props,
    this.hint = '',
    this.label,
    this.onchanged,
    this.max = 200,
    this.hasDecoration = true,
    this.iconSize,
    this.formFieldSize,
    this.fillColor,
    this.filled,
  });

  final String? selectedValue;
  final List<String> props;
  final String? hint, label;
  final double? max;
  final Function(String?)? onchanged;
  final bool hasDecoration;
  final double? iconSize;
  final Color? fillColor;
  final bool? filled;
  final double? formFieldSize;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    final selectedVal = useState(widget.selectedValue);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != '' || widget.label != null)
          Text(
            widget.label!,
            style: AppStyles.w700Style(14, AppColors.grey600),
          ),
        const SizedBox(height: 10),
        Container(
          height: widget.formFieldSize ?? context.height * .074,
          color: AppColors.whiteColor,
          child: FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: !widget.hasDecoration
                    ? const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                          bottom: 18,
                        ),
                      )
                    : InputDecoration(
                        fillColor: widget.fillColor ??
                            AppColors.whiteColor.withOpacity(0.3),
                        errorStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.normalRed,
                        ),
                        filled: widget.filled,
                        errorMaxLines: 3,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.greyColor.withOpacity(0.3)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.grey200,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.greyColor.withOpacity(0.3)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.grey200,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        hintStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey600),
                      ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedVal.value,
                    isDense: true,
                    isExpanded: true,
                    elevation: 1,
                    padding: EdgeInsets.zero,
                    menuMaxHeight: (widget.max!),
                    hint: Text(
                      widget.hint!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF7A7A7A),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackColor,
                    ),
                    dropdownColor: AppColors.whiteColor,
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.greyColor.withOpacity(0.3),
                      size: widget.iconSize ?? 20,
                    ),
                    onChanged: (String? newValue) {
                      selectedVal.value = newValue;
                      state.didChange(newValue);
                      widget.onchanged!(newValue);
                    },
                    borderRadius: BorderRadius.circular(5),
                    items: widget.props.map<DropdownMenuItem<String>>((data) {
                      return DropdownMenuItem<String>(
                        value: data,
                        child: Text(
                          data,
                          style: AppStyles.w500Style(16, AppColors.grey600),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
