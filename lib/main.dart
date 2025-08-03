import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/config/theme/theme.dart';
import 'package:myapp/features/todo/data/data_sources/task_hive_data_source.dart';
import 'package:myapp/features/todo/data/models/task_model.dart';
import 'package:myapp/features/todo/data/repositories/task_repo_impl.dart';
import 'package:myapp/features/todo/domain/use_cases/add_task.dart';
import 'package:myapp/features/todo/domain/use_cases/delete_task.dart';
import 'package:myapp/features/todo/domain/use_cases/get_tasks.dart';
import 'package:myapp/features/todo/domain/use_cases/toggle_task_status.dart';
import 'package:myapp/features/todo/domain/use_cases/update_task.dart';
import 'package:myapp/features/todo/presentation/bloc/task_bloc.dart';
import 'package:myapp/features/todo/presentation/bloc/task_event.dart';
import 'package:myapp/features/todo/presentation/pages/home_page.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Initialize Hive and Open Box
  await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(TaskModelAdapter());
  final taskBox = await Hive.openBox<TaskModel>('tasks');

  // Create data layer
  final dataSource = TaskHiveDataSource(taskBox);
  final taskRepository = TaskRepoImpl(dataSource);

  // Create use cases
  final getTasks = GetTasksUseCase(taskRepository);
  final addTask = AddTaskUseCase(taskRepository);
  final updateTask = UpdateTaskUseCase(taskRepository);
  final deleteTask = DeleteTaskUseCase(taskRepository);
  final toggleTaskStatus = ToggleTaskStatusUseCase(taskRepository);

  runApp(
    MyApp(
      getTasks: getTasks,
      addTask: addTask,
      updateTask: updateTask,
      deleteTask: deleteTask,
      toggleTaskStatus: toggleTaskStatus,
    ),
  );
}

class MyApp extends StatelessWidget {
  final GetTasksUseCase getTasks;
  final AddTaskUseCase addTask;
  final UpdateTaskUseCase updateTask;
  final DeleteTaskUseCase deleteTask;
  final ToggleTaskStatusUseCase toggleTaskStatus;

  const MyApp({
    super.key,
    required this.getTasks,
    required this.addTask,
    required this.updateTask,
    required this.deleteTask,
    required this.toggleTaskStatus,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => TaskBloc(
            getTasks,
            addTask,
            updateTask,
            deleteTask,
            toggleTaskStatus,
          )..add(GetTasks()),
      child: MaterialApp(
        title: 'TODO App',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        home: HomePage(),
      ),
    );
  }
}
