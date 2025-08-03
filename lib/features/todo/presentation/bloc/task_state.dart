import 'package:myapp/features/todo/domain/entities/task.dart';

abstract class TaskState {
  final List<Task>? tasks;

  const TaskState({this.tasks});

  // //Is used to checks if two states are equal or not
  // @override
  // List<Object?> get props => [tasks!];
}

class TaskLoading extends TaskState {
  const TaskLoading();
}

class TaskLoaded extends TaskState {
  const TaskLoaded(List<Task> task) : super(tasks: task);
}

class TaskLoadError extends TaskState {
  final String errorMessage;
  const TaskLoadError({super.tasks, required this.errorMessage});
}
