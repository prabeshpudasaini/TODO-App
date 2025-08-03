import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/constants/strings.dart';
import 'package:myapp/features/todo/presentation/bloc/task_bloc.dart';
import 'package:myapp/features/todo/presentation/bloc/task_event.dart';
import 'package:myapp/features/todo/presentation/widgets/task_form.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Strings.addTask)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TaskForm(
          isEditing: false,
          onSubmit: (task) {
            context.read<TaskBloc>().add(AddTask(task));
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
