import 'package:myapp/core/enums/task_priority.dart';

//Task Entity
class Task {
  final String id;
  final String title;
  final String? description;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime dueDate;
  final TaskPriority priority;

  const Task({
    required this.id,
    required this.title,
    this.description,
    this.isCompleted = false, //initially a task is incomplete
    required this.createdAt,
    required this.dueDate,
    required this.priority,
  });
}
