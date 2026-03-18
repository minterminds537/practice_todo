import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:practice/features/auth/presentation/bloc/auth_bloc.dart';
import 'core/navigation/app_router.dart';
import 'core/utils/constants/app_theme.dart';
import 'features/todo/presentation/bloc/task_bloc.dart';
import 'features/todo/presentation/bloc/task_event.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskBloc>(
              create: (_) => di.sl<TaskBloc>()..add(LoadTasks()),
        ),
        BlocProvider(create: (_) => di.sl<AuthBloc>())
      ],

      child: MaterialApp.router(
        title: 'Clean Todo App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
