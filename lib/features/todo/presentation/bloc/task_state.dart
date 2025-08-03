import 'package:myapp/features/todo/domain/entities/task.dart';

abstract class TaskState {
  final List<Task>? tasks;

  const TaskState({this.tasks});
}

class TaskLoading extends TaskState {
  const TaskLoading();
}

class TaskLoaded extends TaskState {
  final List<Task> allTasks;
  final List<Task> visibleTasks;
  final String filter; // 'All', 'Active', 'Completed'
  final String sortBy; // 'Due Date', 'Priority'

  TaskLoaded({
    required this.allTasks,
    required this.visibleTasks,
    required this.filter,
    required this.sortBy,
  });

  TaskLoaded copyWith({
    List<Task>? allTasks,
    List<Task>? visibleTasks,
    String? filter,
    String? sortBy,
  }) {
    return TaskLoaded(
      allTasks: allTasks ?? this.allTasks,
      visibleTasks: visibleTasks ?? this.visibleTasks,
      filter: filter ?? this.filter,
      sortBy: sortBy ?? this.sortBy,
    );
  }
}

class TaskLoadError extends TaskState {
  final String errorMessage;
  const TaskLoadError({super.tasks, required this.errorMessage});
}
