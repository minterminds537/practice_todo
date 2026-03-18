import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/todo/domain/entities/task.dart';
import '../../features/todo/presentation/pages/add_task_page.dart';
import '../../features/todo/presentation/pages/task_list_page.dart';

class AppRouter {
  static const String root = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String addTask = '/add-task';

  static final GoRouter router = GoRouter(
    initialLocation: login,
    routes: [
      GoRoute(
        path: root,
        builder: (context, state) => const TaskListPage(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: signup,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: addTask,
        builder: (context, state) {
          final task = state.extra as Task?;
          return AddTaskPage(task: task);
        },
      ),
    ],
  );
}
