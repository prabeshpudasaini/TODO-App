import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/core/utils/apply_filter_and_sort.dart';
import 'package:myapp/features/todo/domain/use_cases/add_task.dart';
import 'package:myapp/features/todo/domain/use_cases/delete_task.dart';
import 'package:myapp/features/todo/domain/use_cases/get_tasks.dart';
import 'package:myapp/features/todo/domain/use_cases/toggle_task_status.dart';
import 'package:myapp/features/todo/domain/use_cases/update_task.dart';
import 'package:myapp/features/todo/presentation/bloc/task_event.dart';
import 'package:myapp/features/todo/presentation/bloc/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasksUseCase _getTasks;
  final AddTaskUseCase _addTask;
  final UpdateTaskUseCase _updateTask;
  final DeleteTaskUseCase _deleteTask;
  final ToggleTaskStatusUseCase _toggleTaskStatus;

  TaskBloc(
    this._getTasks,
    this._addTask,
    this._updateTask,
    this._deleteTask,
    this._toggleTaskStatus,
  ) : super(const TaskLoading()) {
    on<GetTasks>(onGetTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<ToggleTaskStatus>(_onToggleTaskStatus);
    on<ChangeFilterEvent>(_onChangeFilter);
    on<ChangeSortEvent>(_onChangeSort);
  }

  //Get all Tasks
  Future<void> onGetTasks(GetTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      final tasks = await _getTasks();
      emit(
        TaskLoaded(
          allTasks: tasks,
          visibleTasks: applyFilterAndSort(tasks, 'All', 'Due Date'),
          filter: 'All',
          sortBy: 'Due Date',
        ),
      );
    } catch (_) {
      emit(TaskLoadError(errorMessage: 'Failed to load tasks'));
    }
  }

  //Add a Task
  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    await _addTask(event.task);
    add(GetTasks());
  }

  //Update existing Task
  Future<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    await _updateTask(event.task);
    add(GetTasks());
  }

  //Delete a Task
  Future<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    await _deleteTask(event.taskId);
    add(GetTasks());
  }

  //Toggle Task status(completed/not completed)
  Future<void> _onToggleTaskStatus(
    ToggleTaskStatus event,
    Emitter<TaskState> emit,
  ) async {
    await _toggleTaskStatus(event.taskId);
    add(GetTasks());
  }

  //Filter Task
  void _onChangeFilter(ChangeFilterEvent event, Emitter<TaskState> emit) {
    if (state is TaskLoaded) {
      final current = state as TaskLoaded;
      final visible = applyFilterAndSort(
        current.allTasks,
        event.filter,
        current.sortBy,
      );
      emit(current.copyWith(filter: event.filter, visibleTasks: visible));
    }
  }

  //Sort
  void _onChangeSort(ChangeSortEvent event, Emitter<TaskState> emit) {
    if (state is TaskLoaded) {
      final current = state as TaskLoaded;
      final visible = applyFilterAndSort(
        current.allTasks,
        current.filter,
        event.sortBy,
      );
      emit(current.copyWith(sortBy: event.sortBy, visibleTasks: visible));
    }
  }
}
