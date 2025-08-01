import 'package:myapp/features/todo/domain/entities/task.dart';
import 'package:myapp/features/todo/domain/repositories/task_repo.dart';

class UpdateTask {
  final TaskRepo repo;

  UpdateTask(this.repo);

  Future<void> call(Task task) {
    return repo.updateTask(task);
  }
}
