import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:kochanet_measure_app/core/utils/colors.dart';
import 'package:kochanet_measure_app/core/utils/enums.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/core/utils/helpers.dart';
import 'package:kochanet_measure_app/widgets/custom_cross_fade.dart';
import 'package:kochanet_measure_app/widgets/custom_nav_bar.dart';

class DashboardView extends StatefulHookWidget {
  const DashboardView({
    super.key,
    this.iMenu,
    this.index,
    this.navigationShell,
  });

  final int? index;
  final Menu? iMenu;
  final StatefulNavigationShell? navigationShell;

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = useState<GlobalKey<ScaffoldState>>(GlobalKey());

    final stream = useStream(InternetConnection().onStatusChange);

    return Scaffold(
      key: scaffoldKey.value,
      bottomNavigationBar: CustomBottomNav(
        selectedMenu: Helpers.getSelectedMenu(widget.navigationShell),
        navigationShell: widget.navigationShell!,
      ),
      body: Stack(
        children: [
          widget.navigationShell ?? const SizedBox.shrink(),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomCrossFade(
              state: stream.data == InternetStatus.disconnected,
              firstChild: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.normalRed,
                ),
                child: const Text(
                  'NOT CONNECTED',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ).paddingSymmetric(v: 5),
              ),
              secondChild: const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
