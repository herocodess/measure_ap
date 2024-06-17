import 'package:flutter/material.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:overlay_support/overlay_support.dart';

class Alerts {
  static void show(
    String content,
    BuildContext context, {
    int duration = 3000,
    Color color = AppColors.normalGreen,
    bool isError = false,
  }) {
    showOverlayNotification(
      (context) {
        return Material(
          color: AppColors.transparentColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 55),
            child: Material(
              elevation: 8,
              color: AppColors.transparentColor,
              child: Stack(
                children: [
                  Container(
                    width: double.maxFinite,
                    height: 65,
                    decoration: BoxDecoration(
                      color: isError ? AppColors.normalRed : color,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(7, 0),
                    child: Container(
                      width: double.maxFinite,
                      height: 65,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      decoration: const BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: isError ? AppColors.normalRed : color,
                            size: 24,
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              content,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor.withOpacity(0.8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      duration: Duration(milliseconds: duration),
    );
  }
}
