import 'package:myapp/features/todo/domain/entities/task.dart';

abstract class TaskEvent {
  const TaskEvent();
}

class GetTasks extends TaskEvent {
  const GetTasks();
}

class AddTask extends TaskEvent {
  final Task task;
  AddTask(this.task);
}

class UpdateTask extends TaskEvent {
  final Task task;
  UpdateTask(this.task);
}

class DeleteTask extends TaskEvent {
  final String taskId;
  DeleteTask(this.taskId);
}

class ToggleTaskStatus extends TaskEvent {
  final String taskId;
  ToggleTaskStatus(this.taskId);
}

class FilterTasks extends TaskEvent {
  final String filter; // "all", "active", "completed"
  FilterTasks(this.filter);
}
