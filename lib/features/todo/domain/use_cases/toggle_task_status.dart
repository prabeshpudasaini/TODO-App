import 'package:myapp/features/todo/domain/repositories/task_repo.dart';

class ToggleTaskStatusUseCase {
  final TaskRepo repo;

  ToggleTaskStatusUseCase(this.repo);

  Future<void> call(String id) {
    return repo.toggleTaskStatus(id);
  }
}
