import 'package:myapp/features/todo/domain/repositories/task_repo.dart';

class ToggleTaskStatus {
  final TaskRepo repo;

  ToggleTaskStatus(this.repo);

  Future<void> call(String id) {
    return repo.toggleTaskStatus(id);
  }
}
