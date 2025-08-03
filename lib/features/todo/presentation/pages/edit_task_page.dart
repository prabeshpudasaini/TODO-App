import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/features/todo/domain/entities/task.dart';
import 'package:myapp/features/todo/presentation/bloc/task_bloc.dart';
import 'package:myapp/features/todo/presentation/bloc/task_event.dart';
import 'package:myapp/features/todo/presentation/widgets/task_form.dart';

class EditTaskPage extends StatelessWidget {
  final Task task;
  const EditTaskPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TaskForm(
          initialTask: task,
          isEditing: true,
          onSubmit: (updatedTask) {
            context.read<TaskBloc>().add(UpdateTask(updatedTask));
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
