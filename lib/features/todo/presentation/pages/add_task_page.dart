import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../../domain/entities/task.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';

class AddTaskPage extends StatelessWidget {
  final Task? task;
  const AddTaskPage({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: task?.title ?? '');
    final descriptionController = TextEditingController(text: task?.description ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text(task == null ? AppStrings.addTask : AppStrings.editTask),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: AppStrings.title),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: AppStrings.description),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text.trim();
                if (title.isNotEmpty) {
                  final newTask = Task(
                    id: task?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
                    title: title,
                    description: descriptionController.text.trim(),
                    isCompleted: task?.isCompleted ?? false,
                  );

                  if (task == null) {
                    context.read<TaskBloc>().add(AddTaskEvent(newTask));
                  } else {
                    context.read<TaskBloc>().add(UpdateTaskEvent(newTask));
                  }
                  context.pop();
                }
              },
              child: Text(task == null ? AppStrings.add : AppStrings.update),
            ),
          ],
        ),
      ),
    );
  }
}
