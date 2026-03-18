import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:practice/features/todo/presentation/auth_inection.dart';
import 'core/services/storage_service.dart';
import 'features/todo/data/datasources/task_local_datasource.dart';
import 'features/todo/data/repositories/task_repository_impl.dart';
import 'features/todo/domain/repositories/task_repository.dart';
import 'features/todo/domain/usecases/add_task.dart';
import 'features/todo/domain/usecases/delete_task.dart';
import 'features/todo/domain/usecases/get_tasks.dart';
import 'features/todo/domain/usecases/update_task.dart';
import 'features/todo/presentation/bloc/task_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External

  
  // We open a box of type Map to store our models as JSON objects

  await initAuth();

  final taskBox = await Hive.openBox<Map>('tasks');

  // Services

  if(sl.isRegistered<StorageService>() == false){
    sl.registerLazySingleton<StorageService>(
          () => HiveStorageService(),
    );
  }

  sl.registerFactory(() => TaskBloc(
        getTasks: sl(),
        addTask: sl(),
        updateTask: sl(),
        deleteTask: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetTasks(sl()));
  sl.registerLazySingleton(() => AddTask(sl()));
  sl.registerLazySingleton(() => UpdateTask(sl()));
  sl.registerLazySingleton(() => DeleteTask(sl()));

  // Repository
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<TaskLocalDataSource>(
    () => TaskLocalDataSourceImpl(storageService: sl()),
  );
}
