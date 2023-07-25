import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:peanut_task/model/repository/profile_repo.dart';
import 'package:peanut_task/providers/auth_provider.dart';
import 'package:peanut_task/providers/profile_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/url.dart';
import 'model/datasource/remote/dio/dio_client.dart';
import 'model/datasource/remote/dio/logging_interceptor.dart';
import 'model/repository/auth_repo.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => DioClient(URL.baseURL, sl(),
      loggingInterceptor: sl(), sharedPreferences: sl()));

  // Repository
  sl.registerLazySingleton(
      () => AuthRepo(dioClient: sl()));
  sl.registerLazySingleton(
      () => ProfileRepo(dioClient: sl()));


  // Provider
  sl.registerFactory(() => AuthProvider(authRepo: sl()));
  sl.registerFactory(() => ProfileProvider(profileRepo: sl()));


  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
