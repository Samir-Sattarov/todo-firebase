import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_firebase/core/entity/task_entity.dart';
import 'package:todo_firebase/core/utils/collections_constants.dart';

import '../../api/firestore_api.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final FirestoreApi api;
  TaskCubit(this.api) : super(TaskInitial());

  load() async {
      emit(TaskLoading());
    try {

      final List<TaskEntity> listTask = [];
      final data =
          await api.get(collection: CollectionConstants.tTaskCollection);

      for (var element in data.docs) {
        final json = element.data();

        listTask.add(TaskEntity.fromJson(json));
      }

      emit(TaskLoaded(tasks: listTask));
    } catch (error) {
      emit(TaskError(message: "Error $error"));
    }
  }

  createTask(TaskEntity task) async {
    try {
      await api.post(
        collection: CollectionConstants.tTaskCollection,
        params: task.toJson(),
      );

      emit(TaskSaved(task));
    } catch (error) {
      emit(TaskError(message: "Error $error"));
    }
  }


  updateTask(TaskEntity task) async {
    try {
      await api.post(
        collection: CollectionConstants.tTaskCollection,
        params: task.toJson(),
      );

      emit(TaskSaved(task));
    } catch (error) {
      emit(TaskError(message: "Error $error"));
    }
  }

  deleteTask(String id) async {

    try {
      await api.delete(
        id: id,
        collection: CollectionConstants.tTaskCollection,
      );

      emit(TaskDeleted(id: id));
    } catch (error) {
      emit(TaskError(message: "Error $error"));
    }
  }
}
