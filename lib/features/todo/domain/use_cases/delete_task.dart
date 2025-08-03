
import 'package:myapp/features/todo/domain/repositories/task_repo.dart';

class DeleteTaskUseCase {
  final TaskRepo repo;

  DeleteTaskUseCase(this.repo);

  Future<void> call(String id) {
    return repo.deleteTask(id);
  }
}
