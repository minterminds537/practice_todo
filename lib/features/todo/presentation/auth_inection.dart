import 'package:get_it/get_it.dart';
import 'package:practice/features/auth/data/reop_impl/auth_repo_impl.dart';
import 'package:practice/features/auth/data/source/auth_local.dart';
import 'package:practice/features/auth/domain/repo/auth_repo.dart';
import 'package:practice/features/auth/domain/use_cases/login.dart';
import 'package:practice/features/auth/domain/use_cases/singup.dart';
import 'package:practice/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../core/services/storage_service.dart';

final sl = GetIt.instance;

Future<void> initAuth() async {
  sl.registerLazySingleton<StorageService>(
        () => HiveStorageService(),
  );

  sl.registerLazySingleton<AuthLocal>(
        () => AuthLocalImpl(storageService: sl<StorageService>()),
  );


  sl.registerLazySingleton<AuthRepo>(
        () => AuthRepoImpl( authLocal: sl<AuthLocal>()),
  );
  // Features - Todo
  sl.registerLazySingleton(() => LoginUseCase( authRepo: sl<AuthRepo>()));
  sl.registerLazySingleton(() => SignUpUseCase(authRepo: sl<AuthRepo>()));
  // Bloc
  sl.registerFactory(() => AuthBloc(
    loginUseCase: sl<LoginUseCase>(),
    signUpUseCase: sl<SignUpUseCase>()
  ));

  // Use cases



  // Repository


  // Data sources

}