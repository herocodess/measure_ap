import 'package:flutter/material.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/core/utils/images.dart';
import 'package:kochanet_measure_app/core/utils/styles.dart';

class CustomSearchWidget extends StatelessWidget {
  const CustomSearchWidget({super.key, required this.onChanged});
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: context.height * 0.06,
      decoration: BoxDecoration(
        color: AppColors.grey500,
        borderRadius: BorderRadius.circular(62),
      ),
      child: TextFormField(
        cursorColor: AppColors.black600,
        cursorHeight: 15,
        onChanged: onChanged,
        onTapOutside: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset(
                AppImages.searchImg,
                scale: 1.7,
              ),
            ),
            border: InputBorder.none,
            hintText: 'Search...',
            hintStyle: AppStyles.w500Style(16, AppColors.grey600)),
      ),
    );
  }
}

class SearchFilterButton extends StatelessWidget {
  const SearchFilterButton({
    super.key,
    required this.onTap,
    this.isActive = false,
  });
  final Function() onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 55,
        decoration: BoxDecoration(
          color: isActive ? AppColors.whiteColor : AppColors.grey500,
          borderRadius: const BorderRadius.all(
            Radius.circular(32),
          ),
          border: Border.all(
              color: isActive ? AppColors.whiteColor : AppColors.grey500),
        ),
        child: Center(
            child: Image.asset(
          AppImages.filterImg,
          scale: 1.8,
          color: isActive ? AppColors.orange700 : null,
        )),
      ),
    );
  }
}
