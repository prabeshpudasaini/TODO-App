import 'package:myapp/features/todo/data/data_sources/task_hive_data_source.dart';
import 'package:myapp/features/todo/data/models/task_model.dart';
import 'package:myapp/features/todo/domain/entities/task.dart';
import 'package:myapp/features/todo/domain/repositories/task_repo.dart';

class TaskRepoImpl implements TaskRepo {
  final TaskHiveDataSource hiveDataSource;

  TaskRepoImpl(this.hiveDataSource);

  @override
  Future<List<Task>> getTasks() async {
    final taskModels = await hiveDataSource.getTasks();
    List<Task> res = taskModels.map((model) => model.toEntity()).toList();
    return res;
  }

  @override
  Future<void> addTask(Task newTask) async {
    final taskModel = TaskModel.fromEntity(newTask);
    return hiveDataSource.addTask(taskModel);
  }

  @override
  Future<void> updateTask(Task task) async {
    final taskModel = TaskModel.fromEntity(task);
    return hiveDataSource.updateTask(taskModel);
  }

  @override
  Future<void> deleteTask(String id) async {
    return hiveDataSource.deleteTask(id);
  }

  @override
  Future<void> toggleTaskStatus(String id) async {
    return hiveDataSource.toggleTaskStatus(id);
  }
}
