part of 'task_cubit.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskError extends TaskState {
  final String message;

  TaskError({required this.message});
}
class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskEntity> tasks;

  TaskLoaded({required this.tasks});
}

class TaskSaved extends TaskState {
  final TaskEntity taskEntity;

  TaskSaved(this.taskEntity);
}

class TaskDeleted extends TaskState {
  final String id;

  TaskDeleted({required this.id});
}

