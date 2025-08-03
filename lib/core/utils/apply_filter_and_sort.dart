  import 'package:myapp/features/todo/domain/entities/task.dart';

List<Task> applyFilterAndSort(
    List<Task> tasks,
    String filter,
    String sortBy,
  ) {
    List<Task> filtered = switch (filter) {
      'Active' => tasks.where((t) => !t.isCompleted).toList(),
      'Completed' => tasks.where((t) => t.isCompleted).toList(),
      _ => tasks,
    };

    switch (sortBy) {
      case 'Priority':
        filtered.sort((a, b) => b.priority.index.compareTo(a.priority.index));
        break;
      case 'Due Date':
      default:
        filtered.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    }

    return filtered;
  }