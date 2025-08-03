import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/config/theme/theme_cubit.dart';
import 'package:myapp/core/constants/strings.dart';
import 'package:myapp/core/utils/get_tile_color.dart';
import 'package:myapp/core/utils/get_tile_text_color.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.myTask),
        actions: [
          _filterMenuButton(),
          _sortTaskMenuButton(),
          _switchThemeButton(),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoaded) {
            final tasks = state.visibleTasks;
            if (tasks.isEmpty) {
              return const Center(child: Text(Strings.noTasksMessage));
            }

            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                final bgColor = getTileColor(task.priority, context);
                final textColor = getTileTextColor(task.priority, context);

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
                      const SnackBar(content: Text(Strings.taskDeleted)),
                    );
                  },
                  child: Card(
                    color: bgColor,
                    child: ListTile(
                      textColor: textColor,
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
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: textColor,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatDate(task.dueDate),
                            style: Theme.of(
                              context,
                            ).textTheme.labelSmall?.copyWith(color: textColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text(Strings.noTasksMessage));
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
        label: const Text(Strings.addTaskTooltip),
      ),
    );
  }

  // Theme Toggle Button
  BlocBuilder<ThemeCubit, ThemeMode> _switchThemeButton() {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return IconButton(
          icon: Icon(
            themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
          ),
          tooltip: Strings.switchThemeTooltip,
          onPressed: () => context.read<ThemeCubit>().toggleTheme(),
        );
      },
    );
  }

  //Menu Button for Filter
  PopupMenuButton<String> _sortTaskMenuButton() {
    return PopupMenuButton<String>(
      onSelected:
          (value) => context.read<TaskBloc>().add(ChangeSortEvent(value)),
      itemBuilder:
          (context) => [
            const PopupMenuItem(
              value: 'Due Date',
              child: Text(Strings.sortDueDate),
            ),
            const PopupMenuItem(
              value: 'Priority',
              child: Text(Strings.sortPriority),
            ),
          ],
      icon: const Icon(Icons.sort),
      tooltip: Strings.sortTooltip,
    );
  }

  //Menu Button for Filter
  PopupMenuButton<String> _filterMenuButton() {
    return PopupMenuButton<String>(
      onSelected:
          (value) => context.read<TaskBloc>().add(ChangeFilterEvent(value)),
      itemBuilder:
          (context) => [
            const PopupMenuItem(value: 'All', child: Text(Strings.showAll)),
            const PopupMenuItem(
              value: 'Active',
              child: Text(Strings.showActive),
            ),
            const PopupMenuItem(
              value: 'Completed',
              child: Text(Strings.showCompleted),
            ),
          ],
      icon: const Icon(Icons.filter_list),
      tooltip: Strings.filterTooltip,
    );
  }

  String _formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';
}
