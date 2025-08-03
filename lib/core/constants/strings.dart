import 'package:myapp/core/enums/task_priority.dart';
import 'package:myapp/features/todo/domain/entities/task.dart';

class Strings {
  static const String mainTitle = "My Tasks";
  static const String deletedTask = "This task was deleted";
  static const String doneAllTask = "You Have Done All Tasks!";
  static const String addNewTask = "Add New ";
  static const String updateCurrentTask = "Update ";
  static const String taskString = "Task";
  static const String titleOfTitleTextField = "What are you planing?";
  static const String addNote = 'Add Note';
  static const String timeString = "Time";
  static const String dateString = "Date";
  static const String deleteTask = "Delete Task";
  static const String addTaskString = "Add Task";
  static const String updateTaskString = "Update Task";
  static const String oopsMsg = "Oops!";
  static const String areYouSure = "Are You Sure?";
}

final List<Task> task = [
  Task(
    id: "1",
    title: "Dart",
    description: "Dart is an Programming Language",
    createdAt: DateTime.now(),
    dueDate: DateTime.now(),
    isCompleted: false,
    priority: TaskPriority.low,
  ),
  Task(
    id: "1",
    title: "Dart",
    description: "Dart is an Programming Language",
    createdAt: DateTime.now(),
    dueDate: DateTime.now(),
    isCompleted: false,
    priority: TaskPriority.low,
  ),
];
