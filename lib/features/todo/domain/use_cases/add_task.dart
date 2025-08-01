import 'package:myapp/features/todo/domain/entities/task.dart';
import 'package:myapp/features/todo/domain/repositories/task_repo.dart';

class AddTask {
  final TaskRepo repo;

  AddTask(this.repo);

  Future<void> call(Task task) {
    return repo.addTask(task);
  }
}
