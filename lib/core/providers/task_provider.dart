import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/core/api/firestore_api.dart';
import 'package:todo_firebase/core/utils/collections_constants.dart';

import '../entity/task_entity.dart';

class TaskProvider extends ChangeNotifier {
  List<TaskEntity> listTask = [];
  final FirestoreApi _api = FirestoreApi();

  createTask(TaskEntity task) async {
    final result = await _api.post(
      collection: CollectionConstants.tTaskCollection,
      params: task.toJson(),
    );

    notifyListeners();
  }

  fetchTasks() async {
    listTask.clear();
    final QuerySnapshot<Map<String, dynamic>> data =
        await _api.get(collection: CollectionConstants.tTaskCollection);

    for (var element in data.docs) {
      final json = element.data();

      listTask.add(TaskEntity.fromJson(json));
    }

    notifyListeners();
  }
}
