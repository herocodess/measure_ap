import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/enums.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/core/utils/images.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({
    super.key,
    required this.selectedMenu,
    required this.navigationShell,
  });
  final Menu selectedMenu;
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 17,
            right: 17,
            top: 14,
            bottom: 30,
          ),
          decoration: const BoxDecoration(
            color: AppColors.bottomNavColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //home options
              BottomNavigationItemWidget(
                onChanged: () {
                  navigationShell.goBranch(0,
                      initialLocation: navigationShell.currentIndex == 0);
                },
                isTabSelected: Menu.home == selectedMenu,
                imageAsset: AppImages.homeNavIcon,
                text: Menu.home.name,
              ),

              //patients options
              BottomNavigationItemWidget(
                onChanged: () {
                  navigationShell.goBranch(1,
                      initialLocation: navigationShell.currentIndex == 1);
                },
                isTabSelected: Menu.patients == selectedMenu,
                imageAsset: AppImages.patientsNavIcon,
                text: Menu.patients.name,
              ),

              //history options
              BottomNavigationItemWidget(
                onChanged: () {
                  navigationShell.goBranch(2,
                      initialLocation: navigationShell.currentIndex == 2);
                },
                isTabSelected: Menu.history == selectedMenu,
                imageAsset: AppImages.historyNavIcon,
                text: Menu.history.name,
              ),

              //settings options
              BottomNavigationItemWidget(
                onChanged: () {
                  navigationShell.goBranch(3,
                      initialLocation: navigationShell.currentIndex == 3);
                },
                isTabSelected: Menu.settings == selectedMenu,
                imageAsset: AppImages.settingsNavIcon,
                text: Menu.settings.name,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BottomNavigationItemWidget extends StatelessWidget {
  const BottomNavigationItemWidget({
    super.key,
    required this.onChanged,
    required this.isTabSelected,
    required this.imageAsset,
    required this.text,
  });

  final Function()? onChanged;
  final bool isTabSelected;
  final String imageAsset;
  final String text;

  @override
  Widget build(BuildContext context) {
    const inactiveColor = AppColors.greyColor;
    const activeColor = AppColors.orange700;

    return Expanded(
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onChanged,
        child: Column(
          children: [
            Image.asset(
              imageAsset,
              color: isTabSelected ? activeColor : inactiveColor,
              scale: 1.9,
            ),
            SizedBox(height: context.height * .01),
            Text(
              text,
              style: TextStyle(
                fontSize: (12),
                color: isTabSelected ? activeColor : inactiveColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
