import 'package:flutter/material.dart';
import 'package:myapp/core/enums/task_priority.dart';

Color getTileTextColor(TaskPriority priority, BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  switch (priority) {
    case TaskPriority.high:
      return colorScheme.onSecondaryContainer;
    case TaskPriority.medium:
      return colorScheme.onTertiaryFixed;
    case TaskPriority.low:
      return colorScheme.onPrimaryFixed;
  }
}
