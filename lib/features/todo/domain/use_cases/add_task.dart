import 'package:myapp/features/todo/domain/entities/task.dart';
import 'package:myapp/features/todo/domain/repositories/task_repo.dart';

class AddTaskUseCase {
  final TaskRepo repo;

  AddTaskUseCase(this.repo);

  Future<void> call(Task task) {
    return repo.addTask(task);
  }
}
