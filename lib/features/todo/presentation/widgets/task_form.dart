import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/core/enums/task_priority.dart';
import 'package:myapp/features/todo/domain/entities/task.dart';

class TaskForm extends StatefulWidget {
  final Task? initialTask;
  final void Function(Task) onSubmit;
  final bool isEditing;

  const TaskForm({
    super.key,
    this.initialTask,
    required this.onSubmit,
    this.isEditing = false,
  });

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TaskPriority _priority;
  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    final task = widget.initialTask;
    _titleController = TextEditingController(text: task?.title ?? '');
    _descriptionController = TextEditingController(
      text: task?.description ?? '',
    );
    _priority = task?.priority ?? TaskPriority.low;
    _dueDate = task?.dueDate;
  }

  void _pickDueDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _dueDate = picked);
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _dueDate != null) {
      final task = Task(
        id: widget.initialTask?.id ?? UniqueKey().toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        isCompleted: widget.initialTask?.isCompleted ?? false,
        priority: _priority,
        dueDate: _dueDate!,
        createdAt: widget.initialTask?.createdAt ?? DateTime.now(),
      );
      widget.onSubmit(task);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateLabel =
        _dueDate == null
            ? 'Pick due date'
            : DateFormat.yMMMd().format(_dueDate!);

    return Form(
      key: _formKey,
      child: ListView(
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              prefixIcon: Icon(Icons.title),
            ),
            validator:
                (value) =>
                    value == null || value.isEmpty ? 'Enter a title' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
              prefixIcon: Icon(Icons.description),
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<TaskPriority>(
            value: _priority,
            decoration: const InputDecoration(
              labelText: 'Priority',
              prefixIcon: Icon(Icons.flag),
            ),
            items:
                TaskPriority.values.map((priority) {
                  return DropdownMenuItem(
                    value: priority,
                    child: Text(priority.name.toUpperCase()),
                  );
                }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => _priority = value);
              }
            },
          ),
          const SizedBox(height: 16),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.date_range),
            title: Text(dateLabel),
            trailing: ElevatedButton.icon(
              onPressed: _pickDueDate,
              icon: const Icon(Icons.calendar_today),
              label: const Text('Select'),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _submit,
            icon: Icon(widget.isEditing ? Icons.save : Icons.add),
            label: Text(widget.isEditing ? 'Update Task' : 'Add Task'),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
