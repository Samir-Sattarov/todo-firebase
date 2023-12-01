// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/core/api/firestore_api.dart';
import 'package:todo_firebase/core/cubits/error_dialog_cubit.dart';
import 'package:todo_firebase/core/cubits/success_dialog_cubit.dart';
import 'package:todo_firebase/core/utils/collections_constants.dart';

import '../entity/task_entity.dart';

class TaskProvider extends ChangeNotifier {
  final List<TaskEntity> listTask = [];

  final SuccessDialogCubit successDialogCubit;
  final ErrorDialogCubit errorDialogCubit;

  final FirestoreApi _api ;

  TaskProvider(this._api, this.successDialogCubit,this.errorDialogCubit);


  createTask(TaskEntity task) async {
    try {
      await _api.post(
        collection: CollectionConstants.tTaskCollection,
        params: task.toJson(),
      );


      successDialogCubit.enable();

    } catch (error) {
      errorDialogCubit.enable();
    }
  }

  deleteTask(TaskEntity task) async {
    try {
      await _api.delete(
          id: task.id, collection: CollectionConstants.tTaskCollection);

      listTask.remove(task);
      notifyListeners();
      successDialogCubit.enable();

    } catch (error) {
      errorDialogCubit.enable();
    }
  }

  fetchTasks() async {
    try {
      listTask.clear();

      final QuerySnapshot<Map<String, dynamic>> data =
          await _api.get(collection: CollectionConstants.tTaskCollection);

      for (var element in data.docs) {
        final json = element.data();

        listTask.add(TaskEntity.fromJson(json));
      }
      successDialogCubit.enable();

    } catch (error) {
      errorDialogCubit.enable();
    }
  }
}
