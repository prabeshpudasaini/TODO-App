import 'package:hive/hive.dart';
import 'package:myapp/core/enums/task_priority.dart';
import 'package:myapp/features/todo/domain/entities/task.dart';

/*
Following command generates required TypeAdapter:

flutter packages pub run build_runner build
*/
part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  bool isCompleted;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final DateTime dueDate;

  @HiveField(6)
  final int priority; // Store enum as int

  TaskModel({
    required this.id,
    required this.title,
    this.description,
    this.isCompleted = false, //initially a task is incomplete
    required this.createdAt,
    required this.dueDate,
    required this.priority,
  });

  // Convert from Domain Entity to Model
  factory TaskModel.fromEntity(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      description: task.description,
      isCompleted: task.isCompleted,
      createdAt: task.createdAt,
      dueDate: task.dueDate,
      priority: task.priority.index,
    );
  }

  // Convert from Model to Domain Entity
  Task toEntity() {
    return Task(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
      createdAt: createdAt,
      dueDate: dueDate,
      priority: TaskPriority.values[priority],
    );
  }
}
