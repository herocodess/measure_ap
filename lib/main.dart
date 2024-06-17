import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kochanet_measure_app/core/managers/app_manager.dart';
import 'package:kochanet_measure_app/core/router/app_router.dart';
import 'package:kochanet_measure_app/core/utils/bloc_observer.dart';
import 'package:kochanet_measure_app/core/utils/extensions.dart';
import 'package:kochanet_measure_app/firebase_options.dart';
import 'package:kochanet_measure_app/providers.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await AppManager.initializeDependencies();
  await locator.allReady();

  /// Calling the [AppBlocObserver] which is a concrete impl of the abstract class [BlocObserver]
  /// which is used to monitor the state changes throughout the app.
  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends HookWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...AppBlocProviders.providers],
      child: OverlaySupport.global(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          onGenerateTitle: (context) => context.l10n.appName,
          supportedLocales: L10n.supportedLocales,
          localizationsDelegates: L10n.localizationsDelegates,
          theme: ThemeData(
            fontFamily: 'Manrope',
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: locator.get<RouterClass>().router,
          builder: (context, widget) => Stack(
            children: [
              Overlay(
                initialEntries: [
                  OverlayEntry(
                    builder: (context) => widget ?? const SizedBox.shrink(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
