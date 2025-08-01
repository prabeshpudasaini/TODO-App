import 'package:myapp/features/todo/domain/entities/task.dart';

abstract class TaskRepo {
  //Get a list of tasks
  Future<List<Task>> getTasks();

  //Add new task
  Future<void> addTask(Task newTask);

  //Update a Task
  Future<void> updateTask(Task task);

  //Delete a Task
  Future<void> deleteTask(String id);

  //Change task status(completed/incomplete)
  Future<void> toggleTaskStatus(String id);
}
