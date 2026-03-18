import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/app_router.dart';
import '../../../../core/utils/constants/app_strings.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appBarTitle),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            if (state.tasks.isEmpty) {
              return const Center(child: Text(AppStrings.noTasks));
            }
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  subtitle: Text(task.description),
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (value) {
                      context.read<TaskBloc>().add(
                            UpdateTaskEvent(
                              task.copyWith(isCompleted: value ?? false),
                            ),
                          );
                    },
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      context.read<TaskBloc>().add(DeleteTaskEvent(task.id));
                    },
                  ),
                  onTap: (){

                  },
                );
              },
            );
          } else if (state is TaskError) {
            return Center(child: Text('${AppStrings.errorPrefix}${state.message}'));
          }
          return const Center(child: Text(AppStrings.noTasks));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRouter.addTask),
        child: const Icon(Icons.add),
      ),
    );
  }
}
