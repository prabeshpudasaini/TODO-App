import 'package:hive/hive.dart';
import 'package:myapp/features/todo/data/models/task_model.dart';

class TaskHiveDataSource {

  
  final Box<TaskModel> taskBox;

  TaskHiveDataSource(this.taskBox);

  Future<List<TaskModel>> getTasks() async {
    return taskBox.values.toList();
  }

  void addTask(TaskModel task) {
    taskBox.put(task.id, task);
  }

  void updateTask(TaskModel task) {
    taskBox.put(task.id, task);
  }

  void deleteTask(String id) {
    taskBox.delete(id);
  }

  void toggleTaskStatus(String id) async {
    final task = taskBox.get(id);
    if (task != null) {
      task.isCompleted = !task.isCompleted;
      //save() persists the data
      await task.save();
    }
  }
}
