import '../../../../core/services/storage_service.dart';
import '../models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskModel>> getTasks();
  Future<void> addTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(String id);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final StorageService storageService;

  TaskLocalDataSourceImpl({required this.storageService});

  @override
  Future<List<TaskModel>> getTasks() async {
    final maps = await storageService.getAll("sdfwd");
    return maps.map((map) => TaskModel.fromJson(map)).toList();
  }

  @override
  Future<void> addTask(TaskModel task) async {
    await storageService.put(task.id,"dsdf", task.toJson());
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    await storageService.put(task.id,"dsdf",  task.toJson());
  }

  @override
  Future<void> deleteTask(String id) async {
    await storageService.delete(id,"sdf");
  }
}
