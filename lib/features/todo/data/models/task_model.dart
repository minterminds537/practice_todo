import '../../domain/entities/task.dart';

class TaskModel extends Task {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  const TaskModel({
    required this.id,
    required this.title,
    this.description = '',
    this.isCompleted = false,
  }) : super(id: id, title: title, description: description, isCompleted: isCompleted);

  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      isCompleted: task.isCompleted,
    );
  }

  Task toEntity() {
    return Task(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }
}
