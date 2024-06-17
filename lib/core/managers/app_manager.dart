import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:kochanet_measure_app/core/router/app_router.dart';
import 'package:kochanet_measure_app/features/home/data/repository/home_repository_impl.dart';
import 'package:kochanet_measure_app/features/home/data/service/home_datasource.dart';

final GetIt locator = GetIt.instance;

class AppManager {
  static Future<void> initializeDependencies() async {
    locator
      //firebase
      ..registerLazySingleton(() => FirebaseFirestore.instance)
      ..registerLazySingleton(() => HomeDataSource(locator()))
      ..registerLazySingleton(() => HomeRepositoryImpl(locator()))

      //router
      ..registerLazySingleton(() => RouterClass());
  }
}
