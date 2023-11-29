import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/core/api/firestore_api.dart';
import 'package:todo_firebase/core/cubits/error_dialog_cubit.dart';
import 'package:todo_firebase/core/utils/collections_constants.dart';

import '../entity/task_entity.dart';

class TaskProvider extends ChangeNotifier {
  final List<TaskEntity> listTask = [];
  final FirestoreApi _api = FirestoreApi();

  final BuildContext context;

  TaskProvider({required this.context});

  createTask(TaskEntity task) async {
    try {
      await _api.post(
        collection: CollectionConstants.tTaskCollection,
        params: task.toJson(),
      );

      notifyListeners();
    } catch (error) {
          // ignore: use_build_context_synchronously
          BlocProvider.of<ErrorDialogCubit>(context).enable();
    }
  }

  deleteTask(TaskEntity task) async {
    try {
      await _api.delete(
          id: task.id, collection: CollectionConstants.tTaskCollection);

      listTask.remove(task);
      notifyListeners();
    } catch (error) {}
  }

  fetchTasks() async {
        BlocProvider.of<ErrorDialogCubit>(context).enable();
    return;
    try {
      listTask.clear();

      final QuerySnapshot<Map<String, dynamic>> data =
          await _api.get(collection: CollectionConstants.tTaskCollection);

      for (var element in data.docs) {
        final json = element.data();

        listTask.add(TaskEntity.fromJson(json));
      }
      notifyListeners();
    } catch (error) {}
  }
}
