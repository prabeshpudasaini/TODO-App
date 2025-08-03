import 'package:myapp/features/todo/domain/entities/task.dart';
import 'package:myapp/features/todo/domain/repositories/task_repo.dart';

class GetTasksUseCase {
  final TaskRepo repo;

  GetTasksUseCase(this.repo);

  Future<List<Task>> call() {
    return repo.getTasks();
  }
}
