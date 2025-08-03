import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/enums/task_priority.dart';
import 'package:myapp/features/todo/domain/entities/task.dart';
import 'package:myapp/features/todo/presentation/bloc/task_bloc.dart';
import 'package:myapp/features/todo/presentation/bloc/task_event.dart';
import 'package:myapp/features/todo/presentation/bloc/task_state.dart';
import 'package:myapp/features/todo/presentation/pages/add_task_page.dart';
import 'package:myapp/features/todo/presentation/pages/edit_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _filter = 'All';
  String _sortBy = 'Due Date';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) => setState(() => _filter = value),
            itemBuilder:
                (context) => [
                  const PopupMenuItem(value: 'All', child: Text('Show All')),
                  const PopupMenuItem(
                    value: 'Active',
                    child: Text('Show Active'),
                  ),
                  const PopupMenuItem(
                    value: 'Completed',
                    child: Text('Show Completed'),
                  ),
                ],
            icon: const Icon(Icons.filter_list),
            tooltip: 'Filter Tasks',
          ),
          PopupMenuButton<String>(
            onSelected: (value) => setState(() => _sortBy = value),
            itemBuilder:
                (context) => [
                  const PopupMenuItem(
                    value: 'Due Date',
                    child: Text('Sort by Due Date'),
                  ),
                  const PopupMenuItem(
                    value: 'Priority',
                    child: Text('Sort by Priority'),
                  ),
                ],
            icon: const Icon(Icons.sort),
            tooltip: 'Sort Tasks',
          ),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          // if (state is TaskLoading) {
          //   return const Center(child: CircularProgressIndicator());
          // } else if (state is TaskLoaded) {
          if (state is TaskLoaded) {
            final tasks = _applyFilterAndSort(state.tasks!);
            if (tasks.isEmpty) {
              return const Center(child: Text('No tasks yet'));
            }

            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                final bgColor = _getTileColor(task.priority, context);

                return Dismissible(
                  key: Key(task.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    context.read<TaskBloc>().add(DeleteTask(task.id));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Task deleted')),
                    );
                  },
                  child: Card(
                    color: bgColor,
                    child: ListTile(
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditTaskPage(task: task),
                            ),
                          ),
                      leading: Checkbox(
                        value: task.isCompleted,
                        onChanged: (_) {
                          context.read<TaskBloc>().add(
                            ToggleTaskStatus(task.id),
                          );
                        },
                      ),
                      title: Text(
                        task.title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          decoration:
                              task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                        ),
                      ),
                      subtitle: Text(
                        task.description!.isNotEmpty ? task.description! : '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.calendar_today, size: 16),
                          const SizedBox(height: 4),
                          Text(
                            _formatDate(task.dueDate),
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No Task Yet'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddTaskPage()),
            ),
        icon: const Icon(Icons.add),
        label: const Text('New Task'),
      ),
    );
  }

  List<Task> _applyFilterAndSort(List<Task> tasks) {
    List<Task> filtered = switch (_filter) {
      'Active' => tasks.where((t) => !t.isCompleted).toList(),
      'Completed' => tasks.where((t) => t.isCompleted).toList(),
      _ => tasks,
    };

    switch (_sortBy) {
      case 'Priority':
        filtered.sort((a, b) => b.priority.index.compareTo(a.priority.index));
        break;
      case 'Due Date':
      default:
        filtered.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    }

    return filtered;
  }

  String _formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';

  Color _getTileColor(TaskPriority priority, BuildContext context) {
    switch (priority) {
      case TaskPriority.high:
        return Colors.red.shade50;
      case TaskPriority.medium:
        return Colors.orange.shade50;
      case TaskPriority.low:
        return Colors.green.shade50;
    }
  }
}
