import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kochanet_measure_app/core/router/app_routes.dart';
import 'package:kochanet_measure_app/core/router/custom_page_route.dart';
import 'package:kochanet_measure_app/features/dashboard/presentation/views/dashboard_view.dart';
import 'package:kochanet_measure_app/features/history/presentation/views/history_details_view.dart';
import 'package:kochanet_measure_app/features/history/presentation/views/history_view.dart';
import 'package:kochanet_measure_app/features/home/data/models/assessment_model.dart';
import 'package:kochanet_measure_app/features/home/presentation/views/assessment_steps_view.dart';
import 'package:kochanet_measure_app/features/home/presentation/views/home_view.dart';
import 'package:kochanet_measure_app/features/home/presentation/views/new_assessment_view.dart';
import 'package:kochanet_measure_app/features/onboarding/presentation/views/splash_view.dart';
import 'package:kochanet_measure_app/features/patients/presentation/views/patients_view.dart';
import 'package:kochanet_measure_app/features/settings/presentation/views/settings_view.dart';

class RouterClass {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  StatefulNavigationShell? navigationShell;

  GoRouter get router {
    return GoRouter(
      initialLocation: AppRoutes.splash.path,
      navigatorKey: navigatorKey,
      routes: [
        StatefulShellRoute.indexedStack(
          parentNavigatorKey: navigatorKey,
          builder: (context, state, shell) {
            navigationShell = shell;
            return DashboardView(
              navigationShell: shell,
            );
          },
          branches: [
            //home view
            StatefulShellBranch(
              initialLocation: AppRoutes.home.path,
              routes: [
                GoRoute(
                  name: AppRoutes.home.name,
                  path: AppRoutes.home.path,
                  builder: (context, state) {
                    return const HomeView();
                  },
                ),
              ],
            ),
            //patients view
            StatefulShellBranch(
              initialLocation: AppRoutes.patients.path,
              routes: [
                GoRoute(
                  name: AppRoutes.patients.name,
                  path: AppRoutes.patients.path,
                  builder: (context, state) {
                    return const PatientsView();
                  },
                ),
              ],
            ),
            //history view
            StatefulShellBranch(
              initialLocation: AppRoutes.history.path,
              routes: [
                GoRoute(
                  name: AppRoutes.history.name,
                  path: AppRoutes.history.path,
                  builder: (context, state) {
                    return const HistoryView();
                  },
                ),
              ],
            ),
            //settings view
            StatefulShellBranch(
              initialLocation: AppRoutes.settings.path,
              routes: [
                GoRoute(
                  name: AppRoutes.settings.name,
                  path: AppRoutes.settings.path,
                  builder: (context, state) {
                    return const SettingsView();
                  },
                ),
              ],
            ),
          ],
        ),

        ///APP ROUTES
        GoRoute(
          parentNavigatorKey: navigatorKey,
          path: AppRoutes.splash.path,
          name: AppRoutes.splash.name,
          builder: (context, state) {
            return const SplashView();
          },
        ),
        GoRoute(
          parentNavigatorKey: navigatorKey,
          path: AppRoutes.newAssessment.path,
          name: AppRoutes.newAssessment.name,
          pageBuilder: (context, state) {
            return TransparentPage(
              child: NewAssessmentView(
                assessment: state.extra as AssessmentModel?,
              ),
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: navigatorKey,
          path: AppRoutes.assessmentSteps.path,
          name: AppRoutes.assessmentSteps.name,
          pageBuilder: (context, state) {
            return TransparentPage(
              child: AssessmentStepsView(
                id: state.extra as String,
              ),
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: navigatorKey,
          path: AppRoutes.historyDetails.path,
          name: AppRoutes.historyDetails.name,
          pageBuilder: (context, state) {
            return TransparentPage(
              child: HistoryDetailsView(
                assessment: state.extra as AssessmentModel,
              ),
            );
          },
        ),
      ],
    );
  }
}
