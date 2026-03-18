import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_local_datasource.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource localDataSource;

  TaskRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addTask(Task task) async {
    await localDataSource.addTask(TaskModel.fromEntity(task));
  }

  @override
  Future<void> deleteTask(String id) async {
    await localDataSource.deleteTask(id);
  }

  @override
  Future<List<Task>> getTasks() async {
    final models = await localDataSource.getTasks();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> updateTask(Task task) async {
    await localDataSource.updateTask(TaskModel.fromEntity(task));
  }
}
