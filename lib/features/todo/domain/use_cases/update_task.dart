import 'package:myapp/features/todo/domain/entities/task.dart';
import 'package:myapp/features/todo/domain/repositories/task_repo.dart';

class UpdateTaskUseCase {
  final TaskRepo repo;

  UpdateTaskUseCase(this.repo);

  Future<void> call(Task task) {
    return repo.updateTask(task);
  }
}
