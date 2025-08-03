
import 'package:flutter/material.dart';
import 'package:myapp/core/enums/task_priority.dart';

Color getTileColor(TaskPriority priority, BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  switch (priority) {
    case TaskPriority.high:

      return colorScheme.secondaryContainer;
    case TaskPriority.medium:

      return colorScheme.tertiaryFixed;
    case TaskPriority.low:
      return colorScheme.primaryFixed;
  }
}
