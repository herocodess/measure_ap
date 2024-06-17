import 'package:flutter/material.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/core/utils/styles.dart';
import 'package:kochanet_measure_app/widgets/custom_input_fields.dart';

class CustomAutoCompleteWidget<T> extends StatefulWidget {
  const CustomAutoCompleteWidget({
    super.key,
    this.selectedValue,
    required this.props,
    required this.controller,
    required this.onItemSelected,
    required this.filterProps,
    required this.getTextToDisplay,
    this.hint = '',
    this.label,
    this.max = 200,
    this.hasDecoration = true,
    this.iconSize,
    this.formFieldSize,
    this.fillColor,
    this.filled,
  });

  final String? selectedValue;
  final List<T> props;
  final String? hint, label;
  final double? max;
  final bool hasDecoration;
  final double? iconSize;
  final Color? fillColor;
  final bool? filled;
  final double? formFieldSize;
  final TextEditingController controller;
  final void Function(T) onItemSelected;
  final List<T> Function(String) filterProps;
  final String Function(T) getTextToDisplay;

  @override
  State<CustomAutoCompleteWidget> createState() =>
      _CustomAutoCompleteWidgetState<T>();
}

class _CustomAutoCompleteWidgetState<T>
    extends State<CustomAutoCompleteWidget<T>> {
  late List<T> _filteredProps;

  void _filter() {
    _filteredProps = widget.filterProps(widget.controller.text.toLowerCase());
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _filteredProps = [];
    widget.controller.addListener(() {
      _filter();
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(() {
      _filter();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InputFields(
          label: widget.label,
          hint: widget.hint ?? '',
          controller: widget.controller,
          onChanged: (val) {},
        ),
        const SizedBox(
          height: 8.0,
        ),
        GestureDetector(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _filteredProps
                .map(
                  (prop) => GestureDetector(
                    onTap: () {
                      widget.onItemSelected(prop);
                      _filteredProps = [];
                      setState(() {});
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: context.width,
                          color: AppColors.whiteColor,
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(widget.getTextToDisplay(prop),
                              style: AppStyles.w600Style(
                                  14, AppColors.blackColor)),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
