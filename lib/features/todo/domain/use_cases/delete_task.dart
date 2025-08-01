
import 'package:myapp/features/todo/domain/repositories/task_repo.dart';

class DeleteTask {
  final TaskRepo repo;

  DeleteTask(this.repo);

  Future<void> call(String id) {
    return repo.deleteTask(id);
  }
}
