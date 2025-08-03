import 'package:flutter_bloc/flutter_bloc.dart';
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
  }

  Future<void> onGetTasks(GetTasks event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    try {
      // final tasks = await _getTasks();
      // if (tasks.isNotEmpty) {
      //   emit(TaskLoaded(tasks));
      // }
          final tasks = await _getTasks(); // even if it's empty
    emit(TaskLoaded(tasks));   
    } catch (e) {
      emit(TaskLoadError(errorMessage: "Failed To Load Data"));
    }
  }

  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    await _addTask(event.task);
    add(GetTasks());
  }

  Future<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    await _updateTask(event.task);
    add(GetTasks());
  }

  Future<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    await _deleteTask(event.taskId);
    add(GetTasks());
  }

  Future<void> _onToggleTaskStatus(
    ToggleTaskStatus event,
    Emitter<TaskState> emit,
  ) async {
    await _toggleTaskStatus(event.taskId);
    add(GetTasks());
  }
}
